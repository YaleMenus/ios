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
            VStack {
                GeometryReader { geometry in
                    Image(systemName: self.iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.width / 2)
                        .foregroundColor(.light)
                        .padding(.top, 260)
                }
                Text(self.subtitle)
                    .font(.appTitle)
                    .foregroundColor(.light)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top, 60)
            }
            Spacer()
        }.frame(maxHeight: .infinity, alignment: .topLeading)
    }
}
