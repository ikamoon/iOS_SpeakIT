//
//  OnboardingWelcomeView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/14.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()

//            LottieView(name: "ai_wave") // AI音声風アニメーション
//                .frame(height: 180)

            Text("SpeakITへようこそ 👋")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing))

            Text("AIがあなたの職種と目標に合わせて\n“話せるIT英語”を自動生成します。")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Spacer()

            Button(action: {}) {
                Text("はじめる")
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
        .background(Color(.systemBackground))
    }
}
