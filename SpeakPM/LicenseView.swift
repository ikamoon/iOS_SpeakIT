import SwiftUI

struct LicenseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("ライセンス表記")
                    .font(.title3)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text("本アプリでは、Mercari, Inc. が公開している「Engineer Vocabulary List」を利用しています。")
                    Text("このデータは、Creative Commons Attribution 4.0 International License（CC BY 4.0）のもとで提供されています。")
                    Link("https://creativecommons.org/licenses/by/4.0/", destination: URL(string: "https://creativecommons.org/licenses/by/4.0/")!)
                        .foregroundColor(.blue)

                    Text("© Mercari, Inc. — Engineer Vocabulary List")
                    Link("https://github.com/mercari/engineer-vocabulary-list", destination: URL(string: "https://github.com/mercari/engineer-vocabulary-list")!)
                        .foregroundColor(.blue)
                }
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
        }
    }
}