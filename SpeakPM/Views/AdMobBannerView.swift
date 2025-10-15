import SwiftUI

// AdMobバナーのラッパー。
// GoogleMobileAds が導入されていない環境ではプレースホルダーを表示します。
struct AdMobBannerView: View {
    var body: some View {
        #if canImport(GoogleMobileAds)
        AdMobWrappedBanner()
        #else
        ZStack {
            Rectangle().fill(Color(.systemGray5))
            Text("AdMob Banner")
                .foregroundColor(.secondary)
        }
        #endif
    }
}

#if canImport(GoogleMobileAds)
import GoogleMobileAds

private struct AdMobWrappedBanner: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let view = GADBannerView(adSize: GADAdSizeBanner)
        // 実運用時は Info.plist に GADApplicationIdentifier を追加し、
        // ここでユニットIDを設定してください。
        view.adUnitID = "YOUR-AD-UNIT-ID"
        view.rootViewController = UIApplication.shared.windows.first?.rootViewController
        view.load(GADRequest())
        return view
    }
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}
#endif