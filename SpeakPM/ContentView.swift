//
//  ContentView.swift
//  SpeakPM
//
//  Flashcard UI for PM vocabulary using SwiftData

import SwiftUI
import SwiftData

struct ContentView: View {
    var deckID: Int
    @Environment(\.modelContext) private var context
//    @Query(sort: \Word.createdAt)
    private var words: [Word] = []

    @State private var currentIndex: Int = 0
    @State private var isRevealed: Bool = false
    @State private var navigateToDecks: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    init(deckID: Int) {
        self.deckID = deckID
        self.words = Word.samples.filter({ $0.deckID == deckID })
    }

    var body: some View {
        VStack(spacing: 16) {
            let safeCurrentWord = words.indices.contains(currentIndex) ? words[currentIndex] : nil
            if let word = safeCurrentWord {
                VStack(spacing: 8) {
                    Spacer()
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
        let review: WordReview
        let fetchDescriptor = FetchDescriptor<WordReview>()
        if let reviews: [WordReview] = try? context.fetch(fetchDescriptor).filter({ $0.wordID == word.id }) {
            if reviews.isEmpty {
                let newReview = WordReview(wordID: word.id)
                review = newReview
            } else {
                review = reviews[0]
            }
            review.lastResult = value
            review.reviewCount += 1
            review.updatedAt = .init()
            word.updatedAt = .init()
            try? context.save()
        }
    }

//    private func seedIfNeeded() {
//        if let dID = deckID {
//            let forDeck = words.filter { $0.deckID == dID }
//            if !forDeck.isEmpty { return }
//            let samples = Word.samples.map { sample in
//                Word(
//                    id: sample.id,
//                    deckID: dID,
//                    japanese: sample.japanese,
//                    japaneseFurigana: sample.japaneseFurigana,
//                    english: sample.english,
//                    exampleEnglish: sample.exampleEnglish,
//                    exampleJapanese: sample.exampleJapanese,
//                    exampleJapaneseFurigana: sample.exampleJapaneseFurigana
//                )
//            }
//            for w in samples { context.insert(w) }
//            try? context.save()
//        } else {
//            if !words.isEmpty { return }
//            for w in Word.samples { context.insert(w) }
//            try? context.save()
//        }
//    }
}

//#Preview {
//    let container = try! ModelContainer(for: Word.self, configurations: [ModelConfiguration(isStoredInMemoryOnly: true)])
//    let ctx = ModelContext(container)
//    for w in Word.samples { ctx.insert(w) }
//    return ContentView()
//        .modelContainer(container)
//}
