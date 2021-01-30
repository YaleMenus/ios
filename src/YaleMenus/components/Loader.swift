import SwiftUI
import Foundation
import AVKit
import AVFoundation

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()

    private func getLoaderImage() -> String {
        return (traitCollection.userInterfaceStyle == .dark ? "loader_dark" : "loader_light")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // TODO: this should be passed as a parameter
        let url = Bundle.main.url(forResource: self.getLoaderImage(), withExtension: "m4v")!
        let player = AVPlayer(url: url)

        // Loop video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
            player.seek(to: CMTime.zero)
            player.play()
        }

        // Formally mute and prevent from interrupting other audio
        player.isMuted = true
        do {
          try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: [AVAudioSession.CategoryOptions.mixWithOthers])
          try AVAudioSession.sharedInstance().setActive(true)
        } catch {}

        player.play()

        playerLayer.player = player
        playerLayer.shouldRasterize = true
        playerLayer.rasterizationScale = UIScreen.main.scale
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct Loader: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                PlayerView()
                    .frame(maxWidth: 215)
                Spacer()
            }
        }.frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
