import Foundation

class HallsViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    @Published var halls: [Hall]?

    func load() {
        nm.getHalls(completion: { halls in
            self.halls = halls
        })
    }

    init() {
        nm.getStatus(completion: { status in
            let VERSION = 1;
            if status.minVersion != nil && VERSION < status.minVersion! {
                self.alertMessage = "You're using an outdated version of Yale Menus that is no longer supported. Please update the app through the App Store to avoid unexpected behavior."
                self.showAlert = true
            }
            if status.message != nil {
                self.alertMessage = status.message!
                self.showAlert = true
            }
        })
        load()
    }
}
