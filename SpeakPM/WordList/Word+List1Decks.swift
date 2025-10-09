import Foundation

extension Word {
    static var list1Decks: [Word] {
        [
            Word(
                id: 0,
                deckID: 1,
                japanese: "チケットを取る",
                japaneseFurigana: "チケットを取(と)る",
                english: "take a ticket",
                partOfSpeech: "",
                exampleEnglish: "I can't take a ticket this week because I have already taken 3.",
                exampleJapanese: "すでに3つチケットを取っているので、今週は取れません。",
                exampleJapaneseFurigana: "すでに3(みっ)つチケットを取(と)っているので、今週(こんしゅう)は取(と)れません。"
            ),
            Word(
                id: 2,
                deckID: 1,
                japanese: "すでに",
                japaneseFurigana: "すでに",
                english: "already",
                partOfSpeech: "adv.",
                exampleEnglish: "ー",
                exampleJapanese: "ー",
                exampleJapaneseFurigana: "ー"
            ),
            Word(
                id: 3,
                deckID: 1,
                japanese: "プルリクを出す",
                japaneseFurigana: "プルリクを出(だ)す",
                english: "make a pull request",
                partOfSpeech: "",
                exampleEnglish: "I made a pull request yesterday.",
                exampleJapanese: "昨日、プルリクを出しました。",
                exampleJapaneseFurigana: "昨日(きのう)、プルリクを出(だ)しました。"
            ),
            Word(
                id: 4,
                deckID: 1,
                japanese: "開発する",
                japaneseFurigana: "開発(かいはつ)する",
                english: "develop",
                partOfSpeech: "v.",
                exampleEnglish: "I'm developing X now.",
                exampleJapanese: "今、Xを開発しています。",
                exampleJapaneseFurigana: "今(いま)、Xを開発(かいはつ)しています。"
            ),
            Word(
                id: 5,
                deckID: 1,
                japanese: "修正する",
                japaneseFurigana: "修正(しゅうせい)する",
                english: "correct",
                partOfSpeech: "v.",
                exampleEnglish: "I think I'll correct it by the end of today.",
                exampleJapanese: "修正は今日中に終わると思います。",
                exampleJapaneseFurigana: "修正(しゅうせい)は今日中(きょうじゅう)に終(お)わると思(おも)います。"
            ),
            Word(
                id: 6,
                deckID: 1,
                japanese: "マージする",
                japaneseFurigana: "マージする",
                english: "merge",
                partOfSpeech: "v.",
                exampleEnglish: "I merged X with Y.",
                exampleJapanese: "XをYにマージしました。",
                exampleJapaneseFurigana: "XをYにマージしました。"
            ),
            Word(
                id: 7,
                deckID: 1,
                japanese: "進める",
                japaneseFurigana: "進(すす)める",
                english: "move forward",
                partOfSpeech: "v. [*transitive verb 他動詞]",
                exampleEnglish: "I'm woving forward with this ticket with Ken.",
                exampleJapanese: "このチケットは、Kenさんと一緒に進めています。",
                exampleJapaneseFurigana: "このチケットは、Kenさんと一緒(いっしょ)に進(すす)めています。"
            ),
            Word(
                id: 8,
                deckID: 1,
                japanese: "[システムが]動く",
                japaneseFurigana: "[システムが]動(うご)く",
                english: "work",
                partOfSpeech: "v.",
                exampleEnglish: "I realized that the system was not working properly.",
                exampleJapanese: "システムがちゃんと動いてないことがわかった。",
                exampleJapaneseFurigana: "システムがちゃんと動(うご)いてないことがわかった。"
            ),
            Word(
                id: 9,
                deckID: 1,
                japanese: "ちゃんと",
                japaneseFurigana: "ちゃんと ※casual",
                english: "properly",
                partOfSpeech: "adv.",
                exampleEnglish: "ー",
                exampleJapanese: "ー",
                exampleJapaneseFurigana: "ー"
            ),
            Word(
                id: 10,
                deckID: 1,
                japanese: "間に合う",
                japaneseFurigana: "間(ま)に合(あ)う",
                english: "be in time",
                partOfSpeech: "",
                exampleEnglish: "It seems that we'll be in time for the next week's release.",
                exampleJapanese: "来週のリリースには間に合いそうです。",
                exampleJapaneseFurigana: "来週(らいしゅう)のリリースには間(ま)に合(あ)いそうです。"
            ),
            Word(
                id: 11,
                deckID: 1,
                japanese: "状態",
                japaneseFurigana: "状態(じょうたい)",
                english: "status",
                partOfSpeech: "n.",
                exampleEnglish: "Is there anything ready for QA?",
                exampleJapanese: "QAしてもらえる状態のものがありますか。",
                exampleJapaneseFurigana: "QAしてもらえる状態(じょうたい)のものがありますか。"
            ),
            Word(
                id: 12,
                deckID: 1,
                japanese: "課題",
                japaneseFurigana: "課題(かだい)",
                english: "issue",
                partOfSpeech: "n.",
                exampleEnglish: "We found some issues.",
                exampleJapanese: "課題が見つかった。",
                exampleJapaneseFurigana: "課題(かだい)が見(み)つかった。"
            ),
            Word(
                id: 13,
                deckID: 1,
                japanese: "要件",
                japaneseFurigana: "要件(ようけん)",
                english: "requirements",
                partOfSpeech: "n.",
                exampleEnglish: "I'll share requirements with TLs tomorrow.",
                exampleJapanese: "要件は明日、テックリード(TL)に共有します。",
                exampleJapaneseFurigana: "要件(ようけん)は明日(あした)、TLに共有(きょうゆう)します。"
            ),
            Word(
                id: 14,
                deckID: 1,
                japanese: "仕様",
                japaneseFurigana: "仕様(しよう)",
                english: "specification document",
                partOfSpeech: "n.",
                exampleEnglish: "The specs haven't been decided yet.",
                exampleJapanese: "まだ仕様が決まってない。",
                exampleJapaneseFurigana: "まだ仕様(しよう)が決(き)まってない。"
            ),
            Word(
                id: 15,
                deckID: 1,
                japanese: "固まる (*自動詞)",
                japaneseFurigana: "固(かた)まる",
                english: "take shape",
                partOfSpeech: "v. (*intransitive verb)",
                exampleEnglish: "The specs haven't taken shape yet.",
                exampleJapanese: "まだ仕様が固まっていません。",
                exampleJapaneseFurigana: "まだ仕様(しよう)が固(かた)まっていません。"
            ),
            Word(
                id: 16,
                deckID: 1,
                japanese: "支障",
                japaneseFurigana: "支障(ししょう)",
                english: "obstacle",
                partOfSpeech: "n.",
                exampleEnglish: "An obstacle interferes with it (our project).",
                exampleJapanese: "(プロジェクトに)支障が出ています。",
                exampleJapaneseFurigana: "(プロジェクトに)支障(ししょう)が出(で)ています。"
            ),
            Word(
                id: 17,
                deckID: 1,
                japanese: "影響",
                japaneseFurigana: "影響(えいきょう)",
                english: "effect",
                partOfSpeech: "n.",
                exampleEnglish: "This is not an incident that has an effect on customers.",
                exampleJapanese: "これは、お客様に影響があるインシデントじゃないです。",
                exampleJapaneseFurigana: "これは、お客様(きゃくさま)に影響(えいきょう)があるインシデントじゃないです。"
            ),
            Word(
                id: 18,
                deckID: 1,
                japanese: "原因",
                japaneseFurigana: "原因(げんいん)",
                english: "cause",
                partOfSpeech: "n.",
                exampleEnglish: "I will look into the causes now.",
                exampleJapanese: "これから原因を調べます。",
                exampleJapaneseFurigana: "これから原因(げんいん)を調(しら)べます。"
            ),
            Word(
                id: 19,
                deckID: 1,
                japanese: "相談する",
                japaneseFurigana: "相談(そうだん)する",
                english: "consult",
                partOfSpeech: "v.",
                exampleEnglish: "I'll consult with my manager.",
                exampleJapanese: "マネージャーに相談する。",
                exampleJapaneseFurigana: "マネージャーに相談(そうだん)する。"
            ),
            Word(
                id: 20,
                deckID: 1,
                japanese: "困る",
                japaneseFurigana: "困(こま)る",
                english: "be in trouble",
                partOfSpeech: "v.",
                exampleEnglish: "Do you have any difficulties?",
                exampleJapanese: "何か困ってることがありますか。",
                exampleJapaneseFurigana: "何(なに)か困(こま)ってることがありますか。"
            ),
            Word(
                id: 21,
                deckID: 1,
                japanese: "[人/チームと]連携する",
                japaneseFurigana: "[人(ひと)/チームと]連携(れんけい)する",
                english: "work together",
                partOfSpeech: "v.",
                exampleEnglish: "We work together with team B to do this (task).",
                exampleJapanese: "これはteam Bと連携してやっていきます。",
                exampleJapaneseFurigana: "これはteam Bと連携(れんけい)してやっていきます。"
            ),
            Word(
                id: 22,
                deckID: 1,
                japanese: "sync(シンク)する",
                japaneseFurigana: "sync(シンク)する",
                english: "sync",
                partOfSpeech: "v.",
                exampleEnglish: "I will sync with TL later.",
                exampleJapanese: "あとでテックリード(TL)とsyncしておきます。",
                exampleJapaneseFurigana: "あとでTLとsyncしておきます。"
            ),
            Word(
                id: 23,
                deckID: 1,
                japanese: "設定する",
                japaneseFurigana: "設定(せってい)する",
                english: "set",
                partOfSpeech: "v.",
                exampleEnglish: "I'll set goals / I am setting goals.",
                exampleJapanese: "目標を設定する。",
                exampleJapaneseFurigana: "目標(もくひょう)を設定(せってい)する。"
            ),
            Word(
                id: 24,
                deckID: 1,
                japanese: "反映する",
                japaneseFurigana: "反映(はんえい)する",
                english: "reflect",
                partOfSpeech: "v.",
                exampleEnglish: "I edited it last week, but it isn't reflected on Jira (yet).",
                exampleJapanese: "先週修正したけど、Jiraに反映されてません。",
                exampleJapaneseFurigana: "先週(せんしゅう)修正(しゅうせい)したけど、Jiraに反映(はんえい)されてません。"
            ),
            Word(
                id: 25,
                deckID: 1,
                japanese: "効率",
                japaneseFurigana: "効率(こうりつ)",
                english: "efficiency",
                partOfSpeech: "n.",
                exampleEnglish: "That method seems efficient.",
                exampleJapanese: "そのやり方は、効率がよさそう。",
                exampleJapaneseFurigana: "そのやり方(かた)は、効率(こうりつ)がよさそう。"
            ),
            Word(
                id: 26,
                deckID: 1,
                japanese: "プルリクを出す",
                japaneseFurigana: "プルリクを出(だ)す",
                english: "create a pull request",
                partOfSpeech: "",
                exampleEnglish: "I created a pull request yesterday.",
                exampleJapanese: "昨日、プルリクを出しました。",
                exampleJapaneseFurigana: "昨日(きのう)、プルリクを出(だ)しました。"
            ),
            Word(
                id: 27,
                deckID: 1,
                japanese: "修正する",
                japaneseFurigana: "修正(しゅうせい)する",
                english: "revise",
                partOfSpeech: "v.",
                exampleEnglish: "I think I'll revise it by the end of today.",
                exampleJapanese: "修正は今日中に終わると思います。",
                exampleJapaneseFurigana: "修正(しゅうせい)は今日中(きょうじゅう)に終(お)わると思(おも)います。"
            ),
            Word(
                id: 28,
                deckID: 1,
                japanese: "進める",
                japaneseFurigana: "進(すす)める",
                english: "proceed with (something)",
                partOfSpeech: "v. [*transitive verb 他動詞]",
                exampleEnglish: "I'm proceeding with this ticket with Ken.",
                exampleJapanese: "このチケットは、Kenさんと一緒に進めています。",
                exampleJapaneseFurigana: "このチケットは、Kenさんと一緒(いっしょ)に進(すす)めています。"
            ),
            Word(
                id: 29,
                deckID: 1,
                japanese: "[システムが]動く",
                japaneseFurigana: "[システムが]動(うご)く",
                english: "operate",
                partOfSpeech: "v.",
                exampleEnglish: "I realized that the system was not operating properly.",
                exampleJapanese: "システムがちゃんと動いてないことがわかった。",
                exampleJapaneseFurigana: "システムがちゃんと動(うご)いてないことがわかった。"
            ),
            Word(
                id: 30,
                deckID: 1,
                japanese: "間に合う",
                japaneseFurigana: "間(ま)に合(あ)う",
                english: "make a deadline",
                partOfSpeech: "",
                exampleEnglish: "It seems that we'll make the release next week.",
                exampleJapanese: "来週のリリースには間に合いそうです。",
                exampleJapaneseFurigana: "来週(らいしゅう)のリリースには間(ま)に合(あ)いそうです。"
            ),
            Word(
                id: 31,
                deckID: 1,
                japanese: "支障",
                japaneseFurigana: "支障(ししょう)",
                english: "hitch",
                partOfSpeech: "n.",
                exampleEnglish: "There’s a hitch in the project.",
                exampleJapanese: "プロジェクトに支障が出ています。",
                exampleJapaneseFurigana: "プロジェクトに支障(ししょう)が出(で)ています。"
            ),
            Word(
                id: 32,
                deckID: 1,
                japanese: "[人/チームと]連携する",
                japaneseFurigana: "[人(ひと)/チームと]連携(れんけい)する",
                english: "align with",
                partOfSpeech: "v.",
                exampleEnglish: "We are aligned with team B to do this (task).",
                exampleJapanese: "これはteam Bと連携してやっていきます。",
                exampleJapaneseFurigana: "これはteam Bと連携(れんけい)してやっていきます。"
            ),
            Word(
                id: 33,
                deckID: 1,
                japanese: "進める",
                japaneseFurigana: "進(すす)める",
                english: "work on",
                partOfSpeech: "v. [*transitive verb 他動詞]",
                exampleEnglish: "I'm working on this ticket with Ken.",
                exampleJapanese: "このチケットは、Kenさんと一緒に進めています。",
                exampleJapaneseFurigana: "このチケットは、Kenさんと一緒(いっしょ)に進(すす)めています。"
            ),
        ]
    }
}
