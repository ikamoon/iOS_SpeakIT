import Foundation
import SwiftData

@Model
final class WordReview {
    @Attribute(.unique) var wordID: Int
    var reviewCount: Int
    var lastResult: Int // 2: 瞬間英作文できた, 1: すぐ分かった, 0: 分からなかった
    // 学習曲線用の状態（Leitner風）
    var stage: Int // 0..5（大きいほど間隔が長い）
    var nextReviewAt: Date? // 次回復習予定日時
    var createdAt: Date
    var updatedAt: Date

    init(wordID: Int) {
        self.wordID = wordID
        self.reviewCount = 0
        self.lastResult = -1
        self.stage = 0
        self.nextReviewAt = nil
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}