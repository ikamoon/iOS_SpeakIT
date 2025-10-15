import Foundation
import AVFoundation

struct SpeechService {
    static let shared = SpeechService()
    private let synthesizer = AVSpeechSynthesizer()

    func speakEnglish(_ text: String) {
        speak(text, language: "en-US")
    }

    func speakJapanese(_ text: String) {
        speak(text, language: "ja-JP")
    }

    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            // サイレントモードでも再生されるように .playback を設定
            try session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try session.setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }

    private func speak(_ text: String, language: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        configureAudioSession()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.pitchMultiplier = 1.0

        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
}