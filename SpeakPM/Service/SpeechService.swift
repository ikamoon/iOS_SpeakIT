import Foundation
import AVFoundation

final class SpeechService {
    static let shared = SpeechService()
    private let synthesizer = AVSpeechSynthesizer()
    private var audioSessionPrepared = false

    init() {
        registerNotifications()
    }

    /// アプリ起動時などに事前に呼び出して、音声セッションを初期化
    func prepareAudioSession() {
        configureAudioSession()
    }

    @MainActor
    func speakEnglish(_ text: String) {
        speak(text, language: "en-US")
    }

    @MainActor
    func speakJapanese(_ text: String) {
        speak(text, language: "ja-JP")
    }

    private func registerNotifications() {
        let center = NotificationCenter.default
        center.addObserver(forName: AVAudioSession.interruptionNotification, object: nil, queue: .main) { [weak self] _ in
            self?.audioSessionPrepared = false
            self?.configureAudioSession()
        }
        center.addObserver(forName: AVAudioSession.routeChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.audioSessionPrepared = false
            self?.configureAudioSession()
        }
    }

    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            // TTS用途に適したカテゴリ/モード
            try session.setCategory(.playback, mode: .spokenAudio, options: [.mixWithOthers])
            try session.setActive(true)
            audioSessionPrepared = true
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }

    @MainActor
    private func speak(_ text: String, language: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        if !audioSessionPrepared { configureAudioSession() }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.pitchMultiplier = 1.0

        synthesizer.stopSpeaking(at: .immediate)
        // 音声サーバの起動に短い余裕を持たせる（少し長めに）
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.synthesizer.speak(utterance)
        }
    }

    @MainActor
    func prewarmTTS() {
        if !audioSessionPrepared { configureAudioSession() }
        let u = AVSpeechUtterance(string: " ")
        u.voice = AVSpeechSynthesisVoice(language: "en-US")
        u.rate = AVSpeechUtteranceDefaultSpeechRate
        u.pitchMultiplier = 1.0
        u.volume = 0.0
        synthesizer.speak(u)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.synthesizer.stopSpeaking(at: .immediate)
        }
    }
}