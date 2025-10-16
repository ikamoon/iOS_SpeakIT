import Foundation
import SwiftData

@Model
final class UsersExamples {
    var wordID: Int
    var usersExamplesID: UUID
    var exampleEn: String
    var exampleJa: String?
    var createdAt: Date
    var updatedAt: Date

    init(wordID: Int, exampleEn: String, exampleJa: String? = nil) {
        self.wordID = wordID
        self.usersExamplesID = UUID()
        self.exampleEn = exampleEn
        self.exampleJa = exampleJa
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}
