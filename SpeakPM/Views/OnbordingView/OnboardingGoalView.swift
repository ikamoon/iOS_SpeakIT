//
//  OnboardingGoalView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingGoalView: View {
    @State private var selectedSituations: Set<String> = []
    @State private var customText = ""
    @State private var goNext = false

    let tags = ["会議", "スタンドアップ", "雑談", "コードレビュー", "面接", "顧客対応"]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("英語で話したい場面を教えてください")
                .font(.title2.bold())

//            FlowLayout(tags) { tag in
//                TagChip(title: tag, isSelected: selectedSituations.contains(tag)) {
//                    if selectedSituations.contains(tag) {
//                        selectedSituations.remove(tag)
//                    } else {
//                        selectedSituations.insert(tag)
//                    }
//                }
//            }

            TextField("自由入力（例：英語で進捗報告したい）", text: $customText)
                .textFieldStyle(.roundedBorder)
                .padding(.top, 12)

            Spacer()

            Button("完了", action: {
                goNext = true
            })
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .navigationDestination(isPresented: $goNext) {
                DeckListView()
            }
        }
        .padding()
    }
}
