import SwiftUI
import SwiftData

struct DeckListView: View {
    @Environment(\.modelContext) private var context
    @State private var isLicensePresented: Bool = false
    @State private var pressedDeckID: Int? = nil
    
    
    
    private var decks: [Deck] = Deck.defaultDecks.map { deck in
        Deck(
            id: deck.id,
            name: deck.name,
            licenceText: deck.licenceText
        )
    }

    var body: some View {
        let columns = [GridItem(.adaptive(minimum: 160, maximum: 240), spacing: 12)]
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundColor(.orange)
                    Text("簡単な単語で、開発現場の英語を使うデッキ")
                        .font(.headline)
                }
                .padding(.horizontal)
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(decks, id: \.self) { deck in
                        NavigationLink(destination: ContentView(deckID: deck.id)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(deck.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(deck.licenceText)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange.opacity(0.1))
                                    .shadow(color: Color.orange.opacity(0.7), radius: 6, x: 0, y: 3)
                            )
                            .scaleEffect(pressedDeckID == deck.id ? 0.98 : 1.0)
                            .animation(.easeOut(duration: 0.08), value: pressedDeckID == deck.id)
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { _ in pressedDeckID = deck.id }
                                    .onEnded { _ in pressedDeckID = nil }
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
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
}

#Preview {
    DeckListView()
}
