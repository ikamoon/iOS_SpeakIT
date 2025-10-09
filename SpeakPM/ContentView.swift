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
                VStack(spacing: 8) {
                    Spacer()
                    HStack(spacing: 8) {
                        Text(word.english)
                            .font(.system(size: 36, weight: .bold))
                            .multilineTextAlignment(.center)
                            .onTapGesture { SpeechService.shared.speakEnglish(word.english) }
                        Button(action: { SpeechService.shared.speakEnglish(word.english) }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                        }
                        .accessibilityLabel("英単語を再生")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

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
                                        Text(word.exampleJapanese)
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
                                        Image(systemName: "hand.tap")
                                            .font(.system(size: 36))
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: 50, alignment: .center)
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
                                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(PressedScaleButtonStyle(scale: 0.98))

                        Button(action: { registerResult(1); nextWord() }) {
                            Text("意味がすぐ\n分かった")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.green)
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(PressedScaleButtonStyle(scale: 0.98))
                        
                        Button(action: { registerResult(2); nextWord() }) {
                            Text("瞬間英作文\nできた")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
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
}

//#Preview {
//    let container = try! ModelContainer(for: Word.self, configurations: [ModelConfiguration(isStoredInMemoryOnly: true)])
//    let ctx = ModelContext(container)
//    for w in Word.samples { ctx.insert(w) }
//    return ContentView()
//        .modelContainer(container)
//}
