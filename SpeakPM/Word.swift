import Foundation
import SwiftData

@Model
final class Word {
    var id: Int
    var deckID: Int
    var japanese: String
    var japaneseFurigana: String
    var english: String
    var exampleEnglish: String
    var exampleJapanese: String
    var exampleJapaneseFurigana: String
    
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: Int,
        deckID: Int,
        japanese: String,
        japaneseFurigana: String,
        english: String,
        exampleEnglish: String,
        exampleJapanese: String,
        exampleJapaneseFurigana: String
    ) {
        self.id = id
        self.deckID = deckID
        self.japanese = japanese
        self.japaneseFurigana = japaneseFurigana
        self.english = english
        self.exampleEnglish = exampleEnglish
        self.exampleJapanese = exampleJapanese
        self.exampleJapaneseFurigana = exampleJapaneseFurigana
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}

extension Word {
    static func getWordsByID(deckID: Int) -> [Word]  {
        switch deckID {
        case 1:
            return list1Decks
        default :
            return []
        }
    }
}
