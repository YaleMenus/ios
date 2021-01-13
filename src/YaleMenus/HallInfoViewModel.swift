import Foundation

class HallInfoViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var hall: Hall
    @Published var managers: [Manager]?

    init(hall: Hall) {
        self.hall = hall
        nm.getManagers(hallId: self.hall.id, completion: { managers in
            self.managers = managers
        })
    }
}
