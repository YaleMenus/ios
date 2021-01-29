import Foundation
import SwiftUI

struct SplashView: View {
    let image: String
    let subtitle: String

    init(image: String, subtitle: String) {
        self.image = image
        self.subtitle = subtitle
    }

    var body: some View {
        VStack {
            Spacer()
            Text(self.subtitle)
                .font(.appTitleLight)
                .foregroundColor(.main)
                .multilineTextAlignment(.center)
            Image(self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 215)
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
