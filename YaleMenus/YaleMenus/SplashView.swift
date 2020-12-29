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
            Image(systemName: self.iconName)
            Text(self.subtitle)
                .frame(maxHeight: .infinity, alignment: .topLeading)
        }
    }
}
