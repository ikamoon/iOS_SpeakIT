import SwiftUI

struct DeckListView: View {
    var body: some View {
        List {
            Section(header: Text("デッキ一覧")) {
                NavigationLink(destination: ContentView()) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Engineer Vocabulary List - list_1")
                            .font(.headline)
                        Text("Mercari, Inc. 提供 — CC BY 4.0")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("デッキ")
    }
}
