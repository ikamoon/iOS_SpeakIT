//
//  UserProfile.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI
import Combine

// ユーザープロファイル（オンボ結果）
struct UserProfile: Codable, Equatable {
    var roles: [String] = []        // 例: ["PM / PdM", "エンジニア"]
    var level: String = "WORKING"   // "BASIC" / "WORKING" / "FLUENT" など
    var situations: [String] = []   // タグ選択
    var customGoal: String = ""     // 自由入力
}

// 永続化（AppStorageで十分）
final class OnboardingStore: ObservableObject {
    var objectWillChange: ObservableObjectPublisher
    
    @AppStorage("speakit.profile") private var savedProfileData: Data = .init()
    @Published var profile = UserProfile()

    init() {
        objectWillChange = ObservableObjectPublisher()
        if let p = try? JSONDecoder().decode(UserProfile.self, from: savedProfileData), !p.roles.isEmpty {
            profile = p
        }
    }
    
    func save() {
        if let d = try? JSONEncoder().encode(profile) {
            savedProfileData = d
        }
    }
}
