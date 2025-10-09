import Foundation
import SwiftData

@Model
final class Deck {
    var id: Int
    var name: String
    var licenceText: String
    var createdAt: Date
    var updatedAt: Date

    // Relationship
    var words: [Word] = []

    init(id: Int, name: String, licenceText: String) {
        self.id = id
        self.name = name
        self.licenceText = licenceText
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}

extension Deck {
    static var defaultDecks: [Deck] {
        [
            Deck(
                id: 1,
                name: "Engineer Vocabulary List - list_1",
                licenceText: "Mercari, Inc. 提供 — CC BY 4.0"
            ),
            Deck(
                id: 2,
                name: "Engineer Vocabulary List - list_2",
                licenceText: "Mercari, Inc. 提供 — CC BY 4.0"
            ),
            Deck(
                id: 3,
                name: "Engineer Vocabulary List - list_3",
                licenceText: "Mercari, Inc. 提供 — CC BY 4.0"
            ),
            Deck(
                id: 4,
                name: "Engineer Vocabulary List - list_4",
                licenceText: "Mercari, Inc. 提供 — CC BY 4.0"
            ),
            Deck(
                id: 5,
                name: "Engineer Vocabulary List - list_5",
                licenceText: "Mercari, Inc. 提供 — CC BY 4.0"
            ),
        ]
    }
}
