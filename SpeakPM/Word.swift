import Foundation
import SwiftData

@Model
final class Word {
    var id: Int
    var deckID: Int
    var japanese: String
    var english: String
    var partOfSpeech: String
    var exampleEnglish: String
    var exampleJapanese: String
    
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: Int,
        deckID: Int,
        japanese: String,
        english: String,
        partOfSpeech: String,
        exampleEnglish: String,
        exampleJapanese: String,
    ) {
        self.id = id
        self.deckID = deckID
        self.japanese = japanese
        self.english = english
        self.partOfSpeech = partOfSpeech
        self.exampleEnglish = exampleEnglish
        self.exampleJapanese = exampleJapanese
        self.createdAt = .init()
        self.updatedAt = .init()
    }
}

extension Word {
    static func getWordsByID(deckID: Int) -> [Word]  {
        switch deckID {
        case 1:
            return list1Decks
        case 2:
            return list2Decks
        case 3:
            return list3Decks
        case 4:
            return list4Decks
        case 5:
            return list5Decks
        default :
            return []
        }
    }
}
