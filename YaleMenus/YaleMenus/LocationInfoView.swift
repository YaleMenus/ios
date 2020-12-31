import Foundation
import SwiftUI

struct InfoRowView : View {
    var icon: String
    var text: String

    init(icon: String, text: String) {
        self.icon = icon
        self.text = text
    }

    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .foregroundColor(.foreground)
            Text(self.text)
                .font(.appBodyMedium)
                .foregroundColor(.foreground)
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
                    InfoRowView(icon: "phone.fill", text: self.model.location.phone)
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
