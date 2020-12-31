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
            HeaderView(text: self.model.location.shortname)
            if (self.model.managers != nil) {
                VStack {
                    Text("Name: ").font(.appBodyMedium) + Text(self.model.location.name)
                }
            } else {
                LoaderView()
            }
        }.padding()
    }
}
