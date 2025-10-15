import Foundation

struct OpenAIService {
    struct ExamplePair: Codable { let en: String; let ja: String }
    
    enum ServiceError: LocalizedError {
        case missingApiKey
        case invalidResponse
        case decodingFailed(String)

        var errorDescription: String? {
            switch self {
            case .missingApiKey:
                return "OpenAIのAPIキーが設定されていません"
            case .invalidResponse:
                return "OpenAIの応答を解釈できませんでした"
            case .decodingFailed(let s):
                return "AI応答のJSON解析に失敗しました: \(s.prefix(200))"
            }
        }
    }

    private var apiKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "OPENAI_API_KEY") as? String ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var model: String {
        (Bundle.main.object(forInfoDictionaryKey: "OPENAI_MODEL") as? String ?? "gpt-3.5-turbo")
    }

    func generateExamples(profile: UserProfile, count: Int = 3) async throws -> [ExamplePair] {
        guard !apiKey.isEmpty else { throw ServiceError.missingApiKey }

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let roles = profile.roles.isEmpty ? "不明" : profile.roles.joined(separator: ", ")
        let situations = profile.situations.isEmpty ? "一般的な業務会話" : profile.situations.joined(separator: ", ")
        let goal = profile.customGoal.isEmpty ? "IT業務で英語を話せるようにする" : profile.customGoal
        let level: String = {
            let lv = profile.level.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            switch lv {
            case "BASIC": return "BASIC"
            case "INTERMEDIATE", "WORKING": return "INTERMEDIATE"
            case "FLUENT": return "FLUENT"
            default: return "INTERMEDIATE"
            }
        }()

        let systemPrompt = """
        あなたはIT分野の英語チューターです。以下のプロフィールに基づき、文脈と難易度を調整してください。
        roles: \(roles)
        level: \(level)
        situations: \(situations)
        goal: \(goal)

        制約:
        - \(count)件の英日ペアを生成。
        - 難易度: BASIC→CEFR A2, INTERMEDIATE→B1-B2, FLUENT→C1。
        - roles/situationsに関連する自然な職務文脈にする。
        - 出力はJSONのみ。配列形式: [{"en":"...","ja":"..."}, ...]
        - 追加の説明、コードブロック、引用符は含めない。
        """

        let userPrompt = "上記条件で英語→日本語の例文ペアを\(count)件、JSONのみで生成してください。"

        let body: [String: Any] = [
            "model": model,
            "messages": [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": userPrompt]
            ],
            "temperature": 0.7,
            "max_tokens": 600
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, _) = try await URLSession.shared.data(for: request)

        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let message = choices.first?["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw ServiceError.invalidResponse
        }

        guard let contentData = content.data(using: .utf8) else { throw ServiceError.invalidResponse }
        do {
            let pairs = try JSONDecoder().decode([ExamplePair].self, from: contentData)
            return pairs
        } catch {
            throw ServiceError.decodingFailed(content)
        }
    }
}