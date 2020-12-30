import Foundation
import SwiftUI

struct SplashView : View {
    let iconName: String
    let subtitle: String

    init(iconName: String, subtitle: String) {
        self.iconName = iconName
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(self.subtitle)
                .font(.appTitleLight)
                .foregroundColor(.foreground)
                .multilineTextAlignment(.center)
            Image(self.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 220)
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
