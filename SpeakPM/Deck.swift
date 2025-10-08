import Foundation
import SwiftData

@Model
final class Deck {
    var name: String
    var createdAt: Date
    var updatedAt: Date

    // Relationship
    var words: [Word] = []

    init(name: String) {
        self.name = name
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}