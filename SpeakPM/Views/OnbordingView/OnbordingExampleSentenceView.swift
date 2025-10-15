//
//  OnbordingExampleSentenceView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct ExampleGeneratingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            ProgressView().scaleEffect(1.4)
            Text("あなた専用の英語フレーズを生成中…").foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct OnbordingExampleSentenceView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var store = OnboardingStore()
    
    // ダミー出力（後でAPI結果で置換）
    @State private var en = "I’ve already updated the release notes."
    @State private var ja = "リリースノートはすでに更新しました。"

    var body: some View {
        VStack(spacing: 16) {
            Text("あなた向けの例文").font(.title3.bold())
            VStack(alignment: .leading, spacing: 8) {
                Text(en).font(.headline)
                Text(ja).foregroundColor(.secondary)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 14).fill(Color(.secondarySystemBackground)))

            HStack {
                Button("speaker.wave.2.fill") {
                    // 後でTTS呼び出し
                }
                .buttonStyle(.bordered)

                Spacer()
                Button("はじめる", action: {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                    
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene
                    let window = windowScene?.windows.first
                    window?.rootViewController?.dismiss(animated: true)
                })
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}
