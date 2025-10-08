import SwiftUI
import SwiftData

struct DeckListView: View {
    @Environment(\.modelContext) private var context
    @State private var isLicensePresented: Bool = false
    @State private var selectedDeckID: Int? = nil
    @State private var isDeckPresented: Bool = false
    
    
    private var decks: [Deck] = Deck.defaultDecks.map { deck in
        Deck(
            id: deck.id,
            name: deck.name,
            licenceText: deck.licenceText
        )
    }

    var body: some View {
        List {
            Section(header: Text("デッキ一覧")) {
                ForEach(decks, id: \.self) { deck in
                    Button(action: {
                        selectedDeckID = deck.id
                        isDeckPresented = true
                    }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(deck.name)
                                .font(.headline)
                            Text(deck.licenceText)
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
        .sheet(isPresented: $isDeckPresented) {
            if let id = selectedDeckID {
                ContentView(deckID: id)
            }
        }
        
    }
}
