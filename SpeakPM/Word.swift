import Foundation
import SwiftData

@Model
final class Word {
    var japanese: String
    var japaneseFurigana: String
    var english: String
    var exampleEnglish: String
    var exampleJapanese: String
    var exampleJapaneseFurigana: String

    var reviewCount: Int
    var lastResult: Int // 2: 瞬間英作文できた, 1: すぐ分かった, 0: 分からなかった
    var createdAt: Date
    var updatedAt: Date

    init(
        japanese: String,
        japaneseFurigana: String,
        english: String,
        exampleEnglish: String,
        exampleJapanese: String,
        exampleJapaneseFurigana: String
    ) {
        self.japanese = japanese
        self.japaneseFurigana = japaneseFurigana
        self.english = english
        self.exampleEnglish = exampleEnglish
        self.exampleJapanese = exampleJapanese
        self.exampleJapaneseFurigana = exampleJapaneseFurigana
        self.reviewCount = 0
        self.lastResult = -1
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}

extension Word {
    static var samples: [Word] {
        [
            Word(
                japanese: "マイルストーン",
                japaneseFurigana: "まいるすとーん",
                english: "Milestone",
                exampleEnglish: "We reached the first milestone of the project roadmap.",
                exampleJapanese: "プロジェクトのロードマップの最初のマイルストーンに到達した。",
                exampleJapaneseFurigana: "ぷろじぇくとのろーどまっぷのさいしょのまいるすとーんにとうたつした。"
            ),
            Word(
                japanese: "利害関係者",
                japaneseFurigana: "りがいかんけいしゃ",
                english: "Stakeholder",
                exampleEnglish: "All stakeholders approved the release plan.",
                exampleJapanese: "すべての利害関係者がリリース計画を承認した。",
                exampleJapaneseFurigana: "すべてのりがいかんけいしゃがりりーすけいかくをしょうにんした。"
            ),
            Word(
                japanese: "バックログ",
                japaneseFurigana: "ばっくろぐ",
                english: "Backlog",
                exampleEnglish: "Let's prioritize items in the product backlog.",
                exampleJapanese: "プロダクトバックログの項目に優先順位をつけよう。",
                exampleJapaneseFurigana: "ぷろだくとばっくろぐのこうもくにゆうせんじゅんいをつけよう。"
            ),
            Word(
                japanese: "ふりかえり",
                japaneseFurigana: "ふりかえり",
                english: "Retrospective",
                exampleEnglish: "We hold a retrospective after each sprint.",
                exampleJapanese: "各スプリント後にふりかえりを行う。",
                exampleJapaneseFurigana: "かくすぷりんとごにふりかえりをおこなう。"
            )
        ]
    }
}