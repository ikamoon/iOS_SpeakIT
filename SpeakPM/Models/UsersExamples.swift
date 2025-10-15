import Foundation
import SwiftData

@Model
final class UsersExamples {
    var wordID: Int
    var usersExamplesID: UUID
    var example: String
    var exampleJa: String?
    var createdAt: Date
    var updatedAt: Date

    init(wordID: Int, example: String, exampleJa: String? = nil) {
        self.wordID = wordID
        self.usersExamplesID = UUID()
        self.example = example
        self.exampleJa = exampleJa
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}
