import Foundation

class LocationViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    
    var locationId: Int? = nil
    @Published var location: Location? = nil
    @Published var date: Date = Date()
    let formatter = DateFormatter()
    @Published var meals: [Meal]? = nil
    
    init(locationId: Int) {
        nm.getLocation(id: locationId, completion: { location in
            self.location = location
        });
        // TODO: we shouldn't need to store this, it should be accessible through self.location.
        self.locationId = locationId
        self.formatter.dateFormat = "yyyy-MM-dd"
        self.getMeals()
    }
    
    func getMeals() {
        // TODO: use self.location?.id
        nm.getMeals(locationId: self.locationId!,
                    date: self.formatter.string(from: self.date),
                    completion: { meals in
            self.meals = meals
        })
    }
}
