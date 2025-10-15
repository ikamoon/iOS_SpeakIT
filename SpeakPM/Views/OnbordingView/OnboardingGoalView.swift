//
//  OnboardingGoalView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var store = OnboardingStore()
    @State private var selectedSituations: [String] = []
    @State private var customText = ""
    @State private var goNext = false

    let tags = ["会議",
                "スタンドアップ",
                "雑談",
                "コードレビュー",
                "面接",
                "顧客対応"]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("英語で話したい場面を教えてください")
                .font(.title2.bold())

//            FlowLayout(items: tags) { tag in
                FlexibleChips(items: tags, selected: Binding(
                    get: {
                        Set(store.profile.situations)
                    },
                    set: {
                        store.profile.situations = Array($0)
                    }
                ))
                
            
//                FlexibleChips(title: tag, isSelected: selectedSituations.contains(tag)) {
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
                store.profile.situations = selectedSituations
                store.save()
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                window?.rootViewController?.dismiss(animated: true)
            })
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

// チップUI（簡易）
struct FlexibleChips: View {
    let items: [String]
    @Binding var selected: Set<String>
    var body: some View {
        FlowLayout(items: items) { item in
            let isOn = selected.contains(item)
            Button {
                if isOn { selected.remove(item) } else { selected.insert(item) }
            } label: {
                Text(item)
                    .padding(.horizontal, 12).padding(.vertical, 8)
                    .background(isOn ? Color.blue.opacity(0.15) : Color.gray.opacity(0.12))
                    .foregroundColor(isOn ? .blue : .primary)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(isOn ? Color.blue : Color.gray.opacity(0.2)))
            }
        }
    }
}

// 簡易 FlowLayout（1ファイルで完結する軽量版）
struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content
    init(items: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items; self.content = content
    }
    var body: some View {
        var width: CGFloat = 0
        var height: CGFloat = 0
        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(Array(items), id: \.self) { item in
                    content(item)
                        .padding(6)
                        .alignmentGuide(.leading) { d in
                            if abs(width - d.width) > geo.size.width { width = 0; height -= d.height }
                            let result = width
                            width -= d.width
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            return result
                        }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
