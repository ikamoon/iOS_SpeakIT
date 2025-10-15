//
//  ContentView.swift
//  SpeakPM
//
//  Flashcard UI for PM vocabulary using SwiftData

import SwiftUI
import SwiftData

struct ContentView: View {
    var deckID: Int = 1
    @Environment(\.modelContext) private var context
    @State private var words: [Word] = []

    @State private var currentIndex: Int = 0
    @State private var isRevealed: Bool = false
    @State private var navigateToDecks: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = true
    @State private var didSpeakFirstOnAppear: Bool = false
    @State private var generatedExample: String? = nil
    @State private var isGenerating: Bool = false
    @State private var generationError: String? = nil
    private let themeColor = Color(red: 0/255.0, green: 163/255.0, blue: 221/255.0)
    private let pastelGreen = Color(red: 128/255.0, green: 255/255.0, blue: 128/255.0)
    private let pastelBlue = Color(red: 148/255.0, green: 219/255.0, blue: 255/255.0)
    private let pastelPink = Color(red: 255/255.0, green: 148/255.0, blue: 191/255.0)
    
    init(deckID: Int) {
        self.deckID = deckID
    }

    var body: some View {
        VStack(spacing: 16) {
            let safeCurrentWord = words.indices.contains(currentIndex) ? words[currentIndex] : nil
            if isLoading {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("英単語をロードしています…")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else if let word = safeCurrentWord {
                VStack(spacing: 18) {
                    Spacer()
                    HStack(spacing: 8) {
                        Text(word.english)
                            .font(.system(size: 36, weight: .bold))
                            .multilineTextAlignment(.center)
                            .onTapGesture { SpeechService.shared.speakEnglish(word.english) }
                            .foregroundColor(Color(red: 93/255.0, green: 93/255.0, blue: 93/255.0))
                        Button(action: { SpeechService.shared.speakEnglish(word.english) }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                        }
                        .accessibilityLabel("英単語を再生")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

//                    Text("💡学習のヒント：\n受動語彙を増やしたい→単語を発音してみる。\n能動語彙を増やしたい→単語を使って例文を作って、喋ってみる")
//                        .font(.footnote)
//                        .foregroundColor(.secondary)
//                        .multilineTextAlignment(.leading)
//                        .padding(.horizontal)

                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                        .overlay(
                            VStack(alignment: .leading, spacing: 12) {
                                if isRevealed {
                                    Group {
                                        Text("意味")
                                            .font(.headline)
                                        Text(word.japanese)
                                    }
                                    Divider()
                                    Group {
                                        Text("例文")
                                            .font(.headline)
                                        HStack(spacing: 8) {
                                            Text(word.exampleEnglish)
                                                .onTapGesture { SpeechService.shared.speakEnglish(word.exampleEnglish) }
                                            Button(action: { SpeechService.shared.speakEnglish(word.exampleEnglish) }) {
                                                Image(systemName: "speaker.wave.2.fill")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.gray)
                                            }
                                            .accessibilityLabel("例文を再生")
                                        }
                                    }
                                    Text(word.exampleJapanese)
                                    
                                    if let example = generatedExample {
                                        HStack(spacing: 8) {
                                            Text(generatedExample ?? word.exampleEnglish)
                                                .onTapGesture { SpeechService.shared.speakEnglish(generatedExample ?? word.exampleEnglish) }
                                            Button(action: { SpeechService.shared.speakEnglish(generatedExample ?? word.exampleEnglish) }) {
                                                Image(systemName: "speaker.wave.2.fill")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.gray)
                                            }
                                            .accessibilityLabel("例文を再生")
                                        }
                                    }
                                    
                                    Button(action: { generateExample(for: word.english) }) {
                                        if isGenerating {
                                            ProgressView()
                                        } else {
                                            Text("自分の例文を生成する")
                                        }
                                    }
                                    .disabled(isGenerating)
                                    
                                    if let error = generationError {
                                        Text(error)
                                            .foregroundColor(.red)
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    HStack(spacing: 8) {
                                        Image(systemName: "hand.tap")
                                            .foregroundColor(.secondary)
                                        Text("英文をタップすると、音声が流れます")
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                } else {
                                    VStack(spacing: 28) {
                                        Text("💡学習のヒント：\n受動語彙を増やしたい→単語を発音してみる。\n能動語彙を増やしたい→単語を使って例文を作って、喋ってみる")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity)
//                                            .frame(maxWidth: 200, alignment: .init(horizontal: .center, vertical: .top))
//                                            .multilineTextAlignment(.leading)
                                            .padding(.horizontal)
                                        Image(systemName: "hand.tap")
                                            .font(.system(size: 36))
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: 300, alignment: .center)
                                }
                            }
                            .padding(16)
                        )
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .onTapGesture { isRevealed.toggle() }
                        .padding(.horizontal)
                }

                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Button(action: { registerResult(0); nextWord() }) {
                            Text("分から\nなかった")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(pastelGreen)
                                .clipShape(Capsule())
                                .shadow(color: pastelGreen.opacity(0.6), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(PressedScaleButtonStyle(scale: 0.98))

                        Button(action: { registerResult(1); nextWord() }) {
                            Text("意味がすぐ\n分かった")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(pastelBlue)
                                .clipShape(Capsule())
                                .shadow(color: pastelBlue.opacity(0.6), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(PressedScaleButtonStyle(scale: 0.98))
                        
                        Button(action: { registerResult(2); nextWord() }) {
                            Text("瞬間英作文\nできた")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(pastelPink)
                                .clipShape(Capsule())
                                .shadow(color: pastelPink.opacity(0.6), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(PressedScaleButtonStyle(scale: 0.98))
                    }
//                    AdMobBannerView()
//                        .frame(height: 50)
                }
                .padding(.horizontal)
            } else {
                VStack(spacing: 12) {
                    Text("単語がありません")
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear {
            loadWords()
        }
        .task(id: deckID) {
            loadWords()
        }
    }

    private var activeWords: [Word] {
//        if let deckID = deckID { return words.filter { $0.deckID == deckID } }
        return words
    }

    private var safeCurrentWord: Word? {
        guard !activeWords.isEmpty else { return nil }
        let index = min(max(0, currentIndex), activeWords.count - 1)
        return activeWords[index]
    }

    private func loadWords() {
        print("loadWords called for deckID: \(deckID)")
        isLoading = true
        // 元データ取得
        let baseWords = Word.getWordsByID(deckID: deckID)

        // 進捗（復習予定）を取得して並び替え
        let fetchDescriptor = FetchDescriptor<WordReview>()
        let reviews: [WordReview] = (try? context.fetch(fetchDescriptor)) ?? []
        let byID = Dictionary(uniqueKeysWithValues: reviews.map { ($0.wordID, $0) })
        let now = Date()

        func isDue(_ review: WordReview?) -> Bool {
            guard let r = review else { return true } // 初回はDue扱い
            guard let next = r.nextReviewAt else { return true }
            return next <= now
        }

        let sorted = baseWords.sorted { a, b in
            let ra = byID[a.id]
            let rb = byID[b.id]
            let aDue = isDue(ra)
            let bDue = isDue(rb)
            if aDue != bDue { return aDue && !bDue }
            let aDate = ra?.nextReviewAt ?? .distantPast
            let bDate = rb?.nextReviewAt ?? .distantPast
            return aDate < bDate
        }

        words = sorted
        isLoading = false
        // 遷移直後に最初の単語を一度だけ自動再生
        if !didSpeakFirstOnAppear, let first = words.first {
            SpeechService.shared.speakEnglish(first.english)
            didSpeakFirstOnAppear = true
        }
        print("Loaded \(words.count) words for deckID: \(deckID)")
    }

    private func nextWord() {
        guard !activeWords.isEmpty else { return }
        let wasLast = currentIndex == activeWords.count - 1
        currentIndex = (currentIndex + 1) % activeWords.count
        isRevealed = false
        if wasLast { dismiss(); return }
        if let w = safeCurrentWord { SpeechService.shared.speakEnglish(w.english) }
    }

    private func registerResult(_ value: Int) {
        guard let word = safeCurrentWord else { return }
        // wordIDで既存レコードを取得（重複があれば最新を残して整理）
        let fetchDescriptor = FetchDescriptor<WordReview>()
//        let fd = FetchDescriptor<WordReview>(predicate: #Predicate { $0.wordID == word.id })
        let fetched = (try? context.fetch(fetchDescriptor).filter({ $0.wordID == word.id })) ?? []
        let review: WordReview
        if fetched.count > 1 {
            let keeper = fetched.sorted { $0.updatedAt > $1.updatedAt }.first!
            for extra in fetched where extra !== keeper {
                context.delete(extra)
            }
            review = keeper
        } else if let existing = fetched.first {
            review = existing
        } else {
            let newReview = WordReview(wordID: word.id)
            context.insert(newReview)
            review = newReview
        }

        review.lastResult = value
        review.reviewCount += 1
        // 学習曲線（Leitner風）: 段階に応じた次回復習間隔
        let clampedStage = max(0, min(5, review.stage))
        var nextStage = clampedStage
        switch value {
        case 0:
            nextStage = max(1, clampedStage - 1)
        case 1:
            nextStage = min(5, clampedStage + 1)
        case 2:
            nextStage = min(5, clampedStage + 1)
        default:
            break
        }
        review.stage = nextStage
        // 段階→日数のマッピング
        let stageDays = [0: 0, 1: 1, 2: 2, 3: 4, 4: 7, 5: 14]
        let days = stageDays[nextStage] ?? 0
        review.nextReviewAt = Calendar.current.date(byAdding: .day, value: days, to: Date())
        review.updatedAt = .init()
        try? context.save()
    }
    
    // Add the function to call OpenAI API:
    private func generateExample(for word: String) {
        isGenerating = true
        generationError = nil
        generatedExample = nil
        let prompt = "英単語 '" + word + "' を使った自然な英語例文を1つ生成してください。"
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": prompt]],
            "max_tokens": 64
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isGenerating = false
                if let error = error {
                    generationError = error.localizedDescription
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let choices = json["choices"] as? [[String: Any]],
                      let message = choices.first?["message"] as? [String: Any],
                      let content = message["content"] as? String else {
                    generationError = "AI例文の取得に失敗しました"
                    return
                }
                generatedExample = content.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }.resume()
    }
}

//#Preview {
//    let container = try! ModelContainer(for: Word.self, configurations: [ModelConfiguration(isStoredInMemoryOnly: true)])
//    let ctx = ModelContext(container)
//    for w in Word.samples { ctx.insert(w) }
//    return ContentView()
//        .modelContainer(container)
//}
