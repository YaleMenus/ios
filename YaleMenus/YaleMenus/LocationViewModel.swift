import Foundation

class LocationViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    var locationId: Int? = nil
    @Published var location: Location? = nil
    @Published var date: Date = Date()
    let formatter = DateFormatter()
    @Published var meals: [Meal]? = nil
    @Published var items: [[Item]?]? = nil

    init(locationId: Int) {
        nm.getLocation(id: locationId, completion: { location in
            self.location = location
        })
        // TODO: we shouldn't need to store this, it should be accessible through self.location.
        self.locationId = locationId
        self.formatter.dateFormat = "yyyy-MM-dd"
        // TODO: only for testing while we don't have updated data.
        self.date = self.formatter.date(from: "2020-09-24")!
        self.getMeals()
    }

    func getMeals() {
        // TODO: use self.location?.id
        nm.getMeals(locationId: self.locationId!,
                    date: self.formatter.string(from: self.date),
                    completion: { meals in
            self.meals = meals
            self.items = [[Item]?](repeating: nil, count: meals.count)
            print(self.meals)
        })
    }

    func getItems(mealIndex: Int) {
        // TODO: ensure this won't be called before nm.getMeals completes above
        if (self.meals != nil && self.items != nil && mealIndex < self.items!.count) {
            if (self.items![mealIndex] != nil) {
                
            }
        }
    }
}
