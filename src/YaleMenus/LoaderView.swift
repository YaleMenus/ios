import SwiftUI
import Foundation
import FLAnimatedImage

struct GifView: UIViewRepresentable {
    let animatedView = FLAnimatedImageView()
    var fileName: String

    func makeUIView(context: UIViewRepresentableContext<GifView>) -> UIView {
        let view = UIView()

        let path: String = Bundle.main.path(forResource: fileName, ofType: "gif")!
        let url = URL(fileURLWithPath: path)
        let gifData = try! Data(contentsOf: url)

        let gif = FLAnimatedImage(animatedGIFData: gifData)
        animatedView.animatedImage = gif

        animatedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animatedView)

        NSLayoutConstraint.activate([
            animatedView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animatedView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GifView>) {}
}

struct LoaderView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                GifView(fileName: "loader")
                    .frame(width: geometry.size.width, height: geometry.size.width)
            }
        }.frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
