import Foundation
import SwiftUI

struct InfoRowView: View {
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
                .frame(width: 25)
            if self.link != nil {
                Button(action: {
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

struct ManagerView: View {
    var manager: Manager

    init(manager: Manager) {
        self.manager = manager
    }

    var body: some View {
        VStack {
            InfoRowView(icon: "person.fill", text: self.manager.name)
            if self.manager.email != nil {
                InfoRowView(icon: "envelope.fill", text: self.manager.email!)
            }
            if self.manager.position != nil {
                InfoRowView(icon: "briefcase.fill", text: self.manager.position!)
            }
        }.padding()
    }
}

struct LocationInfoView: View {
    @ObservedObject var model: LocationInfoViewModel

    init(location: Location) {
        self.model = LocationInfoViewModel(location: location)
    }

    func getMapLink() -> String? {
        let app = UIApplication.shared
        let query = self.model.location.address.replacingOccurrences(of: " ", with: "+")
        if app.canOpenURL(URL(string: "comgooglemaps://")!) {
            return "comgooglemaps://?q=\(query)"
        } else if app.canOpenURL(URL(string: "http://maps.apple.com")!) {
            return "http://maps.apple.com/?q=\(query)"
        }
        return nil
    }

    func getPhoneLink() -> String? {
        return "tel://" + self.model.location.phone.filter { "() -".range(of: String($0)) == nil }
    }

    var body: some View {
        VStack {
            HeaderView(text: "")
            if self.model.managers != nil {
                VStack {
                    Text(self.model.location.name)
                        .font(.appTitle)
                        .foregroundColor(.foreground)
                    InfoRowView(
                        icon: "house",
                        text: self.model.location.address,
                        link: self.getMapLink()
                    )
                    InfoRowView(icon: "location.fill", text: "(\(self.model.location.latitude), \(self.model.location.longitude))")
                    InfoRowView(
                        icon: "phone.fill",
                        text: self.model.location.phone,
                        link: self.getPhoneLink()
                    )
                    Text("Managers")
                        .font(.appTitle)
                        .foregroundColor(.foreground)
                    ForEach(self.model.managers!, id: \.id) { manager in
                        ManagerView(manager: manager)
                    }
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
