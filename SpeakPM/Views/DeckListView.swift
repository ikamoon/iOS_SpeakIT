import SwiftUI
import SwiftData

private struct SelectedDeck: Identifiable { let id: Int }

struct DeckListView: View {
    @Environment(\.modelContext) private var context
    @State private var isLicensePresented: Bool = false
    @State private var selectedDeck: SelectedDeck? = nil
    private let themeColor = Color(red: 0/255.0, green: 163/255.0, blue: 221/255.0)
    
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
                        .foregroundColor(themeColor)
                    Text("簡単な単語で、開発現場の英語を使うデッキ")
                        .font(.headline)
                        .foregroundColor(Color(red: 93/255.0, green: 93/255.0, blue: 93/255.0))
                }
                .padding(.horizontal)
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(decks, id: \.self) { deck in
                        Button {
                            selectedDeck = SelectedDeck(id: deck.id)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(deck.name)
                                    .font(.headline)
                                    .foregroundColor(Color(red: 93/255.0, green: 93/255.0, blue: 93/255.0))
                                Text(deck.licenceText)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(themeColor.opacity(0.1))
                                    .shadow(color: themeColor.opacity(0.7), radius: 6, x: 0, y: 3)
                            )
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(PressedScaleButtonStyle(scale: 0.98))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
//        .navigationTitle("デッキ")
        .toolbar {
            ToolbarItem(placement: .principal) { // タイトル部分をカスタムする
                Text("デッキ")
                    .font(.headline) // フォントを設定
                    .foregroundColor(themeColor) // 文字色を赤色に設定
                    
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isLicensePresented = true }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(themeColor)
                }
                .accessibilityLabel("インフォメーション")
            }
        }
        .sheet(isPresented: $isLicensePresented) {
            LicenseView()
        }
        .sheet(item: $selectedDeck) { d in
            ContentView(deckID: d.id)
        }
    }
}

#Preview {
    DeckListView()
}
