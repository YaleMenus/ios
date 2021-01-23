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

    override init(frame: CGRect) {
        super.init(frame: frame)

        let url = Bundle.main.url(forResource: "loader", withExtension: "m4v")!
        let player = AVPlayer(url: url)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
            player.seek(to: CMTime.zero)
            player.play()
        }
        player.play()

        playerLayer.player = player
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

struct LoaderView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                PlayerView()
                    .frame(width: geometry.size.width / 1.5)
            }
        }.frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
