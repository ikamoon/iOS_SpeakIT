import SwiftUI
import SwiftData

struct DeckListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Word.createdAt) private var words: [Word]
    @State private var isLicensePresented: Bool = false
    
    private var deckNames: [String] {
        Array(Set(words.map { $0.deckName })).sorted()
    }

    var body: some View {
        List {
            Section(header: Text("デッキ一覧")) {
                ForEach(deckNames, id: \.self) { name in
                    NavigationLink(destination: ContentView(deckName: name)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(name)
                                .font(.headline)
                            Text("Mercari, Inc. 提供 — CC BY 4.0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("デッキ")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isLicensePresented = true }) {
                    Image(systemName: "info.circle")
                }
                .accessibilityLabel("インフォメーション")
            }
        }
        .sheet(isPresented: $isLicensePresented) {
            LicenseView()
        }
        
    }

    private func addDeck() {
        let name = "New Deck"
        let w = Word(
            deckName: name,
            japanese: "新規",
            japaneseFurigana: "しんき",
            english: "New",
            exampleEnglish: "-",
            exampleJapanese: "-",
            exampleJapaneseFurigana: "-"
        )
        context.insert(w)
        try? context.save()
    }
}
