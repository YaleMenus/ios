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
            Image(self.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 220)
                
            Text(self.subtitle)
                .font(.appTitle)
                .foregroundColor(.medium)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
