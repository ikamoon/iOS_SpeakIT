//
//  OnboardingWelcomeView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/14.
//

import SwiftUI
import Lottie

struct OnboardingWelcomeView: View {
    @State private var goNext = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                LottieView(filename: "AI animation") // AI音声風アニメーション
                    .frame(height: 180)

                Text("SpeakITへようこそ 👋")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing))

                Text("AIがあなたの職種と目標に合わせて\n“話せるIT英語”を自動生成します。")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                Spacer()

                Button(action: {
                    goNext = true
                }) {
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
            .navigationDestination(isPresented: $goNext) {
                OnboardingRoleView()
            }
        }
    }
}

struct LottieView: UIViewRepresentable {
    var filename: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}
