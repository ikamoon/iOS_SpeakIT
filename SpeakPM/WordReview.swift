import Foundation
import SwiftData

@Model
final class WordReview {
    var wordID: Int
    var reviewCount: Int
    var lastResult: Int // 2: 瞬間英作文できた, 1: すぐ分かった, 0: 分からなかった
    var createdAt: Date
    var updatedAt: Date

    init(wordID: Int) {
        self.wordID = wordID
        self.reviewCount = 0
        self.lastResult = -1
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}