//
//  ContentView.swift
//  SpeakPM
//
//  Flashcard UI for PM vocabulary using SwiftData

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Word.createdAt) private var words: [Word]

    @State private var currentIndex: Int = 0
    @State private var isRevealed: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            if let word = safeCurrentWord {
                VStack(spacing: 8) {
                    Text(word.english)
                        .font(.system(size: 36, weight: .bold))
                        .multilineTextAlignment(.center)
                        .onTapGesture { SpeechService.shared.speakEnglish(word.english) }

                    Text("💡学習のヒント：\n受動語彙を増やしたい→単語を発音してみる。\n能動語彙を増やしたい→単語を使って例文を作って、喋ってみる")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)

                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                        .overlay(
                            VStack(alignment: .leading, spacing: 12) {
                                if isRevealed {
                                    Group {
                                        Text("意味")
                                            .font(.headline)
                                        Text(word.japanese)
                                        Text(word.japaneseFurigana)
                                            .foregroundColor(.secondary)
                                    }
                                    Divider()
                                    Group {
                                        Text("例文")
                                            .font(.headline)
                                        Text(word.exampleEnglish)
                                            .onTapGesture { SpeechService.shared.speakEnglish(word.exampleEnglish) }
                                        Text(word.exampleJapanese)
                                        Text(word.exampleJapaneseFurigana)
                                            .foregroundColor(.secondary)
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
                                    VStack(spacing: 8) {
                                        Text("タップすると、意味や例文が出ます")
                                            .foregroundColor(.secondary)
                                        Image(systemName: "hand.tap")
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            .padding(16)
                        )
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .onTapGesture { isRevealed.toggle() }
                        .padding(.horizontal)
                }

                Spacer()

                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Button(action: { registerResult(0); nextWord() }) {
                            Text("分から\nなかった")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.red)
                                .clipShape(Capsule())
                        }

                        Button(action: { registerResult(1); nextWord() }) {
                            Text("意味がすぐ\n分かった")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.green)
                                .clipShape(Capsule())
                        }
                        
                        Button(action: { registerResult(2); nextWord() }) {
                            Text("瞬間英作文\nできた")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .clipShape(Capsule())
                        }
                    }
//                    AdMobBannerView()
//                        .frame(height: 50)
                }
                .padding(.horizontal)
            } else {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("データを作成しています…")
                        .foregroundColor(.secondary)
                }
            }
        }
        .task { seedIfNeeded() }
    }

    private var safeCurrentWord: Word? {
        guard !words.isEmpty else { return nil }
        let index = min(max(0, currentIndex), words.count - 1)
        return words[index]
    }

    private func nextWord() {
        guard !words.isEmpty else { return }
        currentIndex = (currentIndex + 1) % words.count
        isRevealed = false
//        if let w = safeCurrentWord {
//            SpeechService.shared.speakEnglish(w.english)
//        }
    }

    private func registerResult(_ value: Int) {
        guard let word = safeCurrentWord else { return }
        word.lastResult = value
        word.reviewCount += 1
        word.updatedAt = .init()
        try? context.save()
    }

    private func seedIfNeeded() {
        if !words.isEmpty { return }
        for w in Word.samples { context.insert(w) }
        try? context.save()
    }
}

//#Preview {
//    let container = try! ModelContainer(for: Word.self, configurations: [ModelConfiguration(isStoredInMemoryOnly: true)])
//    let ctx = ModelContext(container)
//    for w in Word.samples { ctx.insert(w) }
//    return ContentView()
//        .modelContainer(container)
//}
