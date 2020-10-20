import Foundation

class LocationViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    
    @Published var location: Location? = nil
    
    init(locationId: Int) {
        nm.getLocation(id: locationId, completion: { location in
            self.location = location;
        });
//        nm.getMeals(location.id, completion: { meals in
//            self.meals = meals;
//        });
    }
}
