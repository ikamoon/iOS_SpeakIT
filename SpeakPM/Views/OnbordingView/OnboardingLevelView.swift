//
//  OnboardingLevelView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingLevelView: View {
    @StateObject var store = OnboardingStore()
    @State private var level = 2.0 // 1=初級, 2=中級, 3=上級
    @State private var goNext = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("英語のレベルを教えてください")
                .font(.title2.bold())
            
            VStack(spacing: 16) {
                Text(levelLabel)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Slider(value: $level, in: 1...3, step: 1)
                    .tint(.blue)
            }
            
            Spacer()
            
            Button(action: {
                store.profile.level = level == 1 ? "BASIC" : (level == 2 ? "INTERMEDIATE" : "FLUENT")
                store.save()
                
                goNext = true
            }) {
                Text("次へ")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [.blue, .indigo], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(16)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 32)
        }
        .padding()
        .onAppear {
            // 復元時
            switch store.profile.level {
            case "BASIC": level = 1
            case "FLUENT": level = 3
            default: level = 2
            }
        }
        .navigationDestination(isPresented: $goNext) {
            OnboardingGoalView()
        }
    }

    var levelLabel: String {
        switch level {
        case 1: "初級（基礎的な会話）"
        case 2: "中級（業務で使える）"
        default: "上級（流暢に話せる）"
        }
    }
}
