//
//  OnboardingLevelView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingLevelView: View {
    @State private var level = 2.0 // 1=初級, 2=中級, 3=上級
    @State private var goNext = false

    var body: some View {
        VStack(spacing: 32) {
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
            
            Button("次へ", action: {
                goNext = true
            })
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .navigationDestination(isPresented: $goNext) {
                OnboardingGoalView()
            }
        }
        .padding()
    }

    var levelLabel: String {
        switch level {
        case 1: "初級（基礎的な会話）"
        case 2: "中級（業務で使える）"
        default: "上級（流暢に話せる）"
        }
    }
}
