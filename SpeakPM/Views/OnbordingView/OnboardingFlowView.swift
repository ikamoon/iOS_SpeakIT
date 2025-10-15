//
//  OnboardingFlowView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingFlowView: View {
    @StateObject var store = OnboardingStore()
    @StateObject private var router = OnboardingRouter()

    var body: some View {
        VStack {
            switch router.step {
            case .welcome:     OnboardingWelcomeView() //OnboardingWelcomeView(next: {
//                router.next()
//                OnboardingRoleView(store: store, next: { router.next() })
//            })
//            case .role:        OnboardingRoleView(store: store, next: { router.next() })
//            case .level:       OnboardingLevelView(store: store, next: { router.next() })
//            case .goal:        OnboardingGoalView(store: store, next: {
//                                   store.save()
//                                   router.next()
//                                   Task {
////                                       try? await ExampleService.shared.mockGenerate()
//                                       router.next()}
//                               })
//            case .generating:  ExampleGeneratingView() // 数秒後にrouter.next()される運用でもOK
//            case .example:     ExampleResultView(store: store, finish: {
//                                   // ここでホームへ遷移 or ルート差し替え
//                               })
            }
        }
        .animation(.easeInOut, value: router.step)
        .padding()
    }
}
