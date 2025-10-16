//
//  Item.swift
//  SpeakPM
//
//  Created by mon ika on 2025/10/08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
