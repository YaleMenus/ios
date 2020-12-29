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
            GeometryReader { geometry in
                Image(systemName: self.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 2)
            }
            Text(self.subtitle)
        }.frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
