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
                japanese: "チケットを取る",
                japaneseFurigana: "チケットを取(と)る",
                english: "take a ticket",
                exampleEnglish: "I can't take a ticket this week because I have already taken 3.",
                exampleJapanese: "すでに3つチケットを取っているので、今週は取れません。",
                exampleJapaneseFurigana: "すでに3(みっ)つチケットを取(と)っているので、今週(こんしゅう)は取(と)れません。"
            ),
            Word(
                japanese: "すでに",
                japaneseFurigana: "すでに",
                english: "adv. already",
                exampleEnglish: "ー",
                exampleJapanese: "ー",
                exampleJapaneseFurigana: "ー"
            ),
            Word(
                japanese: "プルリクを出す",
                japaneseFurigana: "プルリクを出(だ)す",
                english: "make/create a pull request",
                exampleEnglish: "I made a pull request yesterday.",
                exampleJapanese: "昨日、プルリクを出しました。",
                exampleJapaneseFurigana: "昨日(きのう)、プルリクを出(だ)しました。"
            ),
            Word(
                japanese: "開発する",
                japaneseFurigana: "開発(かいはつ)する",
                english: "v. develop",
                exampleEnglish: "I'm developing X now.",
                exampleJapanese: "今、Xを開発しています。",
                exampleJapaneseFurigana: "今(いま)、Xを開発(かいはつ)しています。"
            ),
            Word(
                japanese: "修正する",
                japaneseFurigana: "修正(しゅうせい)する",
                english: "v. correct, revise",
                exampleEnglish: "I think I'll revise it by the end of today.",
                exampleJapanese: "修正は今日中に終わると思います。",
                exampleJapaneseFurigana: "修正(しゅうせい)は今日中(きょうじゅう)に終(お)わると思(おも)います。"
            ),
            Word(
                japanese: "マージする",
                japaneseFurigana: "マージする",
                english: "v. merge",
                exampleEnglish: "I merged X with Y.",
                exampleJapanese: "XをYにマージしました。",
                exampleJapaneseFurigana: "XをYにマージしました。"
            ),
            Word(
                japanese: "進める",
                japaneseFurigana: "進(すす)める",
                english: "v. [*transitive verb 他動詞]\n1. move forward, proceed with (something)\n2. work on",
                exampleEnglish: "I'm working on this ticket with Ken.",
                exampleJapanese: "このチケットは、Kenさんと一緒に進めています。",
                exampleJapaneseFurigana: "このチケットは、Kenさんと一緒(いっしょ)に進(すす)めています。"
            ),
            Word(
                japanese: "[システムが]動く",
                japaneseFurigana: "[システムが]動(うご)く",
                english: "v. work, operate",
                exampleEnglish: "I realized that the system was not working properly.",
                exampleJapanese: "システムがちゃんと動いてないことがわかった。",
                exampleJapaneseFurigana: "システムがちゃんと動(うご)いてないことがわかった。"
            ),
            Word(
                japanese: "ちゃんと",
                japaneseFurigana: "ちゃんと ※casual",
                english: "adv. properly",
                exampleEnglish: "ー",
                exampleJapanese: "ー",
                exampleJapaneseFurigana: "ー"
            ),
            Word(
                japanese: "間に合う",
                japaneseFurigana: "間(ま)に合(あ)う",
                english: "be in time, make a deadline",
                exampleEnglish: "It seems that we'll make the release next week.",
                exampleJapanese: "来週のリリースには間に合いそうです。",
                exampleJapaneseFurigana: "来週(らいしゅう)のリリースには間(ま)に合(あ)いそうです。"
            ),
            Word(
                japanese: "状態",
                japaneseFurigana: "状態(じょうたい)",
                english: "n. status",
                exampleEnglish: "Is there anything ready for QA?",
                exampleJapanese: "QAしてもらえる状態のものがありますか。",
                exampleJapaneseFurigana: "QAしてもらえる状態(じょうたい)のものがありますか。"
            ),
            Word(
                japanese: "課題",
                japaneseFurigana: "課題(かだい)",
                english: "n. issue",
                exampleEnglish: "We found some issues.",
                exampleJapanese: "課題が見つかった。",
                exampleJapaneseFurigana: "課題(かだい)が見(み)つかった。"
            ),
            Word(
                japanese: "要件",
                japaneseFurigana: "要件(ようけん)",
                english: "n. requirements",
                exampleEnglish: "I'll share requirements with TLs tomorrow.",
                exampleJapanese: "要件は明日、テックリード(TL)に共有します。",
                exampleJapaneseFurigana: "要件(ようけん)は明日(あした)、TLに共有(きょうゆう)します。"
            ),
            Word(
                japanese: "仕様",
                japaneseFurigana: "仕様(しよう)",
                english: "n. specification document",
                exampleEnglish: "The specs haven't been decided yet.",
                exampleJapanese: "まだ仕様が決まってない。",
                exampleJapaneseFurigana: "まだ仕様(しよう)が決(き)まってない。"
            ),
            Word(
                japanese: "固まる (*自動詞)",
                japaneseFurigana: "固(かた)まる (*intransitive verb)",
                english: "v. take shape (*intransitive verb)",
                exampleEnglish: "The specs haven't taken shape yet.",
                exampleJapanese: "まだ仕様が固まっていません。",
                exampleJapaneseFurigana: "まだ仕様(しよう)が固(かた)まっていません。"
            ),
            Word(
                japanese: "支障",
                japaneseFurigana: "支障(ししょう)",
                english: "n. obstacle, hitch",
                exampleEnglish: "It interferes with it (our project).",
                exampleJapanese: "それによって(プロジェクトに)支障が出ています。",
                exampleJapaneseFurigana: "それによって(プロジェクトに)支障(ししょう)が出(で)ています。"
            ),
            Word(
                japanese: "影響",
                japaneseFurigana: "影響(えいきょう)",
                english: "n. effect",
                exampleEnglish: "This is not an incident that has an effect on customers.",
                exampleJapanese: "これは、お客様に影響があるインシデントじゃないです。",
                exampleJapaneseFurigana: "これは、お客様(きゃくさま)に影響(えいきょう)があるインシデントじゃないです。"
            ),
            Word(
                japanese: "原因",
                japaneseFurigana: "原因(げんいん)",
                english: "n. cause",
                exampleEnglish: "I will look into the causes now.",
                exampleJapanese: "これから原因を調べます。",
                exampleJapaneseFurigana: "これから原因(げんいん)を調(しら)べます。"
            ),
            Word(
                japanese: "相談する",
                japaneseFurigana: "相談(そうだん)する",
                english: "v. consult",
                exampleEnglish: "I'll consult with my manager.",
                exampleJapanese: "マネージャーに相談する。",
                exampleJapaneseFurigana: "マネージャーに相談(そうだん)する。"
            ),
            Word(
                japanese: "困る",
                japaneseFurigana: "困(こま)る",
                english: "v. be in trouble",
                exampleEnglish: "Do you have any difficulties?",
                exampleJapanese: "何か困ってることがありますか。",
                exampleJapaneseFurigana: "何(なに)か困(こま)ってることがありますか。"
            ),
            Word(
                japanese: "[人/チームと]連携する",
                japaneseFurigana: "[人(ひと)/チームと]連携(れんけい)する",
                english: "v. work together, align with",
                exampleEnglish: "We are aligned with team B to do this (task).",
                exampleJapanese: "これはteam Bと連携してやっていきます。",
                exampleJapaneseFurigana: "これはteam Bと連携(れんけい)してやっていきます。"
            ),
            Word(
                japanese: "sync(シンク)する",
                japaneseFurigana: "sync(シンク)する",
                english: "v. sync",
                exampleEnglish: "I will sync with TL later.",
                exampleJapanese: "あとでテックリード(TL)とsyncしておきます。",
                exampleJapaneseFurigana: "あとでTLとsyncしておきます。"
            ),
            Word(
                japanese: "設定する",
                japaneseFurigana: "設定(せってい)する",
                english: "v. set",
                exampleEnglish: "I'll set goals / I am setting goals.",
                exampleJapanese: "目標を設定する。",
                exampleJapaneseFurigana: "目標(もくひょう)を設定(せってい)する。"
            ),
            Word(
                japanese: "反映する",
                japaneseFurigana: "反映(はんえい)する",
                english: "v. reflect",
                exampleEnglish: "I edited it last week, but it isn't reflected on Jira (yet).",
                exampleJapanese: "先週修正したけど、Jiraに反映されてません。",
                exampleJapaneseFurigana: "先週(せんしゅう)修正(しゅうせい)したけど、Jiraに反映(はんえい)されてません。"
            ),
            Word(
                japanese: "効率",
                japaneseFurigana: "効率(こうりつ)",
                english: "n. efficiency",
                exampleEnglish: "That method seems efficient.",
                exampleJapanese: "そのやり方は、効率がよさそう。",
                exampleJapaneseFurigana: "そのやり方(かた)は、効率(こうりつ)がよさそう。"
            ),
        ]
    }
}
