//
//  OnboardingRoleView.swift
//  SpeakIT
//
//  Created by mon ika on 2025/10/15.
//

import SwiftUI

struct OnboardingRoleView: View {
    @StateObject var store = OnboardingStore()
    @State private var selectedRoles: Set<String> = []
    @State private var goNext = false
    
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
            
            Text("複数選択できます")
                .font(.subheadline)
                .foregroundColor(.secondary)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)]) {
                ForEach(roles, id: \.1) { role in
                    RoleCard(emoji: role.0, title: role.1, isSelected: selectedRoles.contains(role.1)) {
                        if selectedRoles.contains(role.1) {
                            selectedRoles.remove(role.1)
                        } else {
                            selectedRoles.insert(role.1)
                        }
                    }
                }
            }

            Spacer()

            Button(action: {
                store.profile.roles = selectedRoleTitles
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
        .padding().navigationDestination(isPresented: $goNext) {
            OnboardingLevelView()
        }
    }
}

struct RoleCard: View {
    let emoji: String
    let title: String
    let isSelected: Bool
    let tap: () -> Void
    var body: some View {
        Button(action: tap) {
            Text(emoji)
                .font(.largeTitle)
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .primary)
                .frame(maxWidth: .infinity, minHeight: 64)
                .background(
                    isSelected ? AnyView(LinearGradient(colors: [.blue,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                               : AnyView(Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(isSelected ? .clear : Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

// Convert selectedRoles to [String] containing only titles (絵文字を抜かして)
extension OnboardingRoleView {
    var selectedRoleTitles: [String] {
        // roles: [(emoji, title)]
        roles.map { $0.1 }.filter { selectedRoles.contains($0) }
    }
}
