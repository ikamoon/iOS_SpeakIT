import Foundation
import SwiftData

@Model
final class UsersExamples {
    @Attribute(.unique) var wordID: Int
    var example: String
    var createdAt: Date
    var updatedAt: Date

    init(wordID: Int, text: String) {
        self.wordID = wordID
        self.example = text
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}
