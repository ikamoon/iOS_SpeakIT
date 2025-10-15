//
//  OnboardingRouter.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import Foundation
import Combine

enum OnboardingStep: Int, CaseIterable {
    case welcome//, role, level, goal//, generating, example
}

final class OnboardingRouter: ObservableObject {
    var objectWillChange: ObservableObjectPublisher
    
    init() { objectWillChange = ObservableObjectPublisher() }
    
    @Published var step: OnboardingStep = .welcome
    func next() {
        if let s = OnboardingStep(rawValue: step.rawValue + 1) {
            step = s
        }
    }
    func to(_ s: OnboardingStep) { step = s }
}
