import Foundation

class HallsViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var halls: [Hall]?

    func load() {
        nm.getHalls(completion: { halls in
            self.halls = halls
        })
    }

    init() {
        load()
    }
}
