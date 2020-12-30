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
            Image(systemName: self.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 220)
                .foregroundColor(.light)
            Text(self.subtitle)
                .font(.appTitle)
                .foregroundColor(.light)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
