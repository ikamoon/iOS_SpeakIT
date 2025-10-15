//
//  OnbordingExampleSentenceView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct ExampleGeneratingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            ProgressView().scaleEffect(1.4)
            Text("あなた専用の英語フレーズを生成中…").foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct OnbordingExampleSentenceView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var store = OnboardingStore()
    
    struct Example: Identifiable { let id = UUID(); let en: String; let ja: String }
    @State private var examples: [Example] = []
    @State private var isGenerating: Bool = true
    @State private var generationError: String? = nil

    var body: some View {
        VStack(spacing: 16) {
            Text("あなた向けの例文").font(.title3.bold())
            if let err = generationError {
                Text(err).foregroundColor(.red).font(.footnote)
            }

            if isGenerating {
                ExampleGeneratingView()
                    .frame(maxWidth: .infinity)
            } else {
                VStack(spacing: 12) {
                    ForEach(examples) { ex in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(ex.en).font(.headline)
                            Text(ex.ja).foregroundColor(.secondary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground)))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.15)))
                        HStack {
                            Button(action: { SpeechService.shared.speakEnglish(ex.en) }) {
                                Image(systemName: "speaker.wave.2.fill")
                            }
                            .buttonStyle(.bordered)
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                Button("再生成") { generateExamples() }
                    .buttonStyle(.bordered)
                Spacer()
                Button("はじめる") {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene
                    let window = windowScene?.windows.first
                    window?.rootViewController?.dismiss(animated: true)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear { generateExamples() }
    }
    
    private func generateExamples() {
        isGenerating = true
        examples = []
        generationError = nil
        let p = store.profile
        Task {
            do {
                let pairs = try await OpenAIService().generateExamples(profile: p, count: 3)
                let mapped = pairs.map { Example(en: $0.en, ja: $0.ja) }
                examples = mapped
                isGenerating = false
            } catch {
                // 失敗時はテンプレートにフォールバック
                generationError = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                let selected = Set(p.situations)
                var pool: [(String,String)] = []
                if selected.contains("会議") {
                    pool.append(("Let's align on the agenda for today's meeting.", "今日の議題をそろえましょう。"))
                }
                if selected.contains("スタンドアップ") {
                    pool.append(("Yesterday I fixed a bug; today I will work on testing.", "昨日はバグを直し、今日はテストに取り組みます。"))
                }
                if selected.contains("雑談") {
                    pool.append(("How's your day going? Did you watch the keynote?", "今日はどうですか？基調講演は見ましたか？"))
                }
                if selected.contains("コードレビュー") {
                    pool.append(("Could you take a look at my pull request?", "プルリクエストのレビューをお願いできますか？"))
                }
                if selected.contains("面接") {
                    pool.append(("Could you tell me about a challenging project you led?", "あなたが主導した難しいプロジェクトについて教えてください。"))
                }
                if selected.contains("顧客対応") {
                    pool.append(("I'll follow up with the customer and share the timeline.", "お客様へフォローし、スケジュールを共有します。"))
                }
                if pool.isEmpty {
                    pool = [
                        ("Could you share a quick update on the current status?", "現在の進捗を簡単に共有してもらえますか？"),
                        ("Let's prioritize tasks for this sprint.", "このスプリントのタスクの優先順位を決めましょう。"),
                        ("Please let me know if you need any support.", "もし支援が必要なら教えてください。")
                    ]
                }
                let role = p.roles.first ?? "エンジニア"
                let adjusted = pool.prefix(3).map { en, ja in
                    let pref = role.contains("PM") || role.contains("PdM") ? "As a PM, " : ""
                    let en2 = pref.isEmpty ? en : pref + en.prefix(1).lowercased() + en.dropFirst()
                    return Example(en: en2, ja: ja)
                }
                examples = adjusted
                isGenerating = false
            }
        }
    }
}
