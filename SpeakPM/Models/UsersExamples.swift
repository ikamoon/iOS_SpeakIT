import Foundation
import SwiftData

@Model
final class UsersExamples {
    var wordID: Int
    var usersExamplesID: UUID
    var example: String
    var createdAt: Date
    var updatedAt: Date

    init(wordID: Int, example: String) {
        self.wordID = wordID
        self.usersExamplesID = UUID()
        self.example = example
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}
