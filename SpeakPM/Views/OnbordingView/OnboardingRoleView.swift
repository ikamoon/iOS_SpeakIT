//
//  OnboardingRoleView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingRoleView: View {
    @State private var selectedRoles: Set<String> = []
    @State private var showDeckList = false

    let roles = [
        ("💼", "PM / PdM"),
        ("🧑‍💻", "エンジニア"),
        ("🎨", "デザイナー"),
        ("🧾", "QA / テスター"),
        ("📚", "学生"),
        ("✍️", "フリーランス")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("あなたの職種を教えてください")
                .font(.title2.bold())

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)]) {
                ForEach(roles, id: \.1) { role in
//                    RoleCardView(emoji: role.0, title: role.1, isSelected: selectedRoles.contains(role.1)) {
//                        if selectedRoles.contains(role.1) {
//                            selectedRoles.remove(role.1)
//                        } else {
//                            selectedRoles.insert(role.1)
//                        }
//                    }
                }
            }

            Spacer()

            
            Button("次へ", action: {
                showDeckList = true
            })
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .navigationDestination(isPresented: $showDeckList) {
                DeckListView()
            }
        }
        .padding()
    }
}
