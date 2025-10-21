//
//  OnboardingLevelView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingLevelView: View {
    @StateObject var store = OnboardingStore()
    @State private var level = 1 // 1=初級, 2=中級, 3=上級
    @State private var goNext = false

    var body: some View {
        VStack(spacing: 24) {
            Text("英語のレベルを教えてください")
                .font(.title2.bold())

            // 単一選択の縦並びボタン
            VStack(spacing: 12) {
                levelButton(title: "初級（基礎的な会話）", value: 1)
                levelButton(title: "中級（業務で使える）", value: 2)
                levelButton(title: "上級（流暢に話せる）", value: 3)
            }

            Spacer()

            Button(action: {
                store.profile.level = (level == 1) ? "BASIC" : ((level == 2) ? "INTERMEDIATE" : "FLUENT")
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

    // ボタン生成ヘルパー
    private func levelButton(title: String, value: Int) -> some View {
        Button(action: { level = value }) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(level == value ? .white : .primary)
                Spacer()
                if level == value {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(
                level == value
                ? AnyView(LinearGradient(colors: [.blue,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                : AnyView(Color(.secondarySystemBackground))
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(level == value ? .clear : Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}
