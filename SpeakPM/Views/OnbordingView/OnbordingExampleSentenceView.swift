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
                if selected.contains("日程調整") {
                    pool.append(("Does tomorrow afternoon work for you?", "明日の午後はご都合いかがですか？"))
                }
                if selected.contains("プレゼン") {
                    pool.append(("I'll walk you through the proposal with slides.", "スライドで提案内容をご説明します。"))
                }
                if selected.contains("障害対応") {
                    pool.append(("We detected an incident; we're investigating the root cause.", "インシデントを検知し、原因を調査しています。"))
                }
                if selected.contains("要件定義") {
                    pool.append(("Let's clarify the scope and non-functional requirements.", "スコープと非機能要件を明確にしましょう。"))
                }
                if selected.contains("仕様相談") {
                    pool.append(("Could we discuss the edge cases and constraints?", "仕様のエッジケースと制約について相談できますか？"))
                }
                if selected.contains("見積り") {
                    pool.append(("I'll provide a rough estimate by end of day.", "本日中に概算見積りをお送りします。"))
                }
                if selected.contains("リリース") {
                    pool.append(("The release is scheduled for Friday 5 PM JST.", "リリースは金曜の17時（JST）を予定しています。"))
                }
                if selected.contains("ドキュメント") {
                    pool.append(("Please document the API changes and update the README.", "APIの変更点をドキュメント化し、READMEを更新してください。"))
                }
                if selected.contains("設計レビュー") {
                    pool.append(("Can you review the architecture diagram and trade-offs?", "アーキテクチャ図とトレードオフのレビューをお願いします。"))
                }
                if selected.contains("メール") {
                    pool.append(("I'll follow up via email with the summary.", "要点をメールでフォローします。"))
                }
                if selected.contains("1on1") {
                    pool.append(("In our 1-on-1, I'd like feedback on my communication.", "1on1では、コミュニケーションのフィードバックをいただきたいです。"))
                }
                if selected.contains("外部折衝") {
                    pool.append(("I'll negotiate the terms and share the revised contract.", "条件交渉を行い、修正契約書を共有します。"))
                }
                if selected.contains("オフサイト") {
                    pool.append(("Let's plan the offsite agenda and logistics.", "オフサイトの議題と段取りを計画しましょう。"))
                }
                if selected.contains("バグ報告") {
                    pool.append(("I found a bug; here's a minimal reproducible example.", "バグを見つけました。最小の再現例はこちらです。"))
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
