//
//  SplashView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI
import OSLog

struct SplashView: View {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SplashView")
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            if !hasCompletedOnboarding {
                NavigationStack {
                    OnboardingWelcomeView()
                }
            } else {
                NavigationStack {
                    DeckListView()
                }
//                Group {
//                    if AuthManager.shared.isAuthenticated || AuthManager.shared.isAnonymous {
//                        ContentView()
//                    } else {
//                        AuthView()
//                    }
//                }
            }
        } else {
            ZStack {
//                Image("splash_background")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
                
                VStack {
                    Image("app_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(40)
                    
                    Text("SpeakIT")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                logger.info("スプラッシュ画面が表示されました")
                    // 音声合成のセッションを早期初期化して、音声サーバ接続の失敗を防止
                    SpeechService.shared.prepareAudioSession()
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
                // TTSを無音で一度だけウォームアップして、初回の接続失敗を避ける
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    SpeechService.shared.prewarmTTS()
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
