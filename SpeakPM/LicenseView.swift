import SwiftUI
import SwiftData

struct LicenseView: View {
    @Query(sort: \WordReview.updatedAt, order: .reverse)
    private var reviews: [WordReview]

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

                #if DEBUG
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Debug: WordReview の状況")
                        .font(.headline)

                    if reviews.isEmpty {
                        Text("記録なし")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(reviews, id: \.wordID) { r in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("wordID: \(r.wordID)")
                                    Spacer()
                                    Text("stage: \(r.stage)")
                                }
                                HStack {
                                    Text("count: \(r.reviewCount)")
                                    Spacer()
                                    if let next = r.nextReviewAt {
                                        Text("next: \(next.formatted(date: .abbreviated, time: .shortened))")
                                    } else {
                                        Text("next: -")
                                    }
                                }
                            }
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                #endif
            }
            .padding()
        }
    }
}