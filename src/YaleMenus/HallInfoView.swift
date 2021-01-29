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
                .foregroundColor(.main)
                .frame(width: 25)
            if self.link != nil {
                Button(action: {
                    let url = URL(string: self.link!)!
                    UIApplication.shared.open(url)
                }) {
                    Text(self.text)
                        .font(.appBodyBold)
                        .foregroundColor(.main)
                }
            } else {
                Text(self.text)
                    .font(.appBodyMedium)
                    .foregroundColor(.main)
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

struct HallInfoView: View {
    @ObservedObject var model: HallInfoViewModel

    init(hall: Hall) {
        self.model = HallInfoViewModel(hall: hall)
    }

    func getMapLink() -> String? {
        let app = UIApplication.shared
        let query = self.model.hall.address.replacingOccurrences(of: " ", with: "+")
        if app.canOpenURL(URL(string: "comgooglemaps://")!) {
            return "comgooglemaps://?q=\(query)"
        } else if app.canOpenURL(URL(string: "http://maps.apple.com")!) {
            return "http://maps.apple.com/?q=\(query)"
        }
        return nil
    }

    func getPhoneLink() -> String? {
        return "tel://" + self.model.hall.phone.filter { "() -".range(of: String($0)) == nil }
    }

    var body: some View {
        VStack {
            Header(text: "")
            if self.model.managers != nil {
                VStack {
                    Text(self.model.hall.name)
                        .font(.appTitle)
                        .foregroundColor(.main)
                    InfoRowView(
                        icon: "house",
                        text: self.model.hall.address,
                        link: self.getMapLink()
                    )
                    InfoRowView(icon: "location.fill", text: "(\(self.model.hall.latitude), \(self.model.hall.longitude))")
                    InfoRowView(
                        icon: "phone.fill",
                        text: self.model.hall.phone,
                        link: self.getPhoneLink()
                    )
                    Text("Managers")
                        .font(.appTitle)
                        .foregroundColor(.main)
                    ForEach(self.model.managers!, id: \.id) { manager in
                        ManagerView(manager: manager)
                    }
                }
                .multilineTextAlignment(.leading)
                .foregroundColor(.main)
                .frame(maxHeight: .infinity, alignment: .top)
            } else {
                LoaderView()
            }
        }.padding()
    }
}
