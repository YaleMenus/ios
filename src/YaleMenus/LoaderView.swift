import SwiftUI
import Foundation

struct LoaderView : View {
    @State private var isAnimating = false

    var animation: Animation {
        Animation.linear(duration: 0.5)
        .repeatForever()
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image("logo").resizable()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: geometry.size.width / 2)
                    .opacity(self.isAnimating ? 1 : 0)
                    .animation(self.animation)
                    .onAppear {
                        self.isAnimating = true
                    }
            }
        }.frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
