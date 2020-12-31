import Foundation
import SwiftUI

struct InfoRowView : View {
    var icon: String
    var text: String
    var link: String?

    init(icon: String, text: String, link: String? = nil) {
        self.icon = icon
        self.text = text
        self.link = link
    }

    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .foregroundColor(.foreground)
            if (self.link != nil) {
                Button(action: {
                    print(self.link)
                    let url = URL(string: self.link!)!
                    UIApplication.shared.open(url)
                }) {
                    Text(self.text)
                        .font(.appBodyBold)
                        .foregroundColor(.foreground)
                }
            } else {
                Text(self.text)
                    .font(.appBodyMedium)
                    .foregroundColor(.foreground)
            }
            Spacer()
        }
    }
}

struct LocationInfoView : View {
    @ObservedObject var model: LocationInfoViewModel

    init(location: Location) {
        self.model = LocationInfoViewModel(location: location)
    }
    
    var body: some View {
        VStack {
            HeaderView(text: "")
            if (self.model.managers != nil) {
                VStack {
                    Text(self.model.location.name)
                        .font(.appTitle)
                        .foregroundColor(.foreground)
                    InfoRowView(icon: "house", text: self.model.location.address)
                    InfoRowView(icon: "location.fill", text: "(\(self.model.location.latitude), \(self.model.location.longitude))")
                    InfoRowView(
                        icon: "phone.fill",
                        text: self.model.location.phone,
                        link: "tel://" + self.model.location.phone.filter { "() -".range(of: String($0)) == nil }
                    )
                }
                .multilineTextAlignment(.leading)
                .foregroundColor(.foreground)
                .frame(maxHeight: .infinity, alignment: .top)
            } else {
                LoaderView()
            }
        }.padding()
    }
}
