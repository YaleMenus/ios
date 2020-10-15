import Foundation

class LocationViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    
    @Published var location: Location
    
    init(location: Location) {
        self.location = location
//        nm.getMeals(location.id, completion: { meals in
//            self.meals = meals;
//        });
    }
    
    func openLocation() {
        
    }
}
