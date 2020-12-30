import Foundation

class LocationViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    let settings = Settings()

    @Published var location: Location
    @Published var meals: [Date: [Meal]] = [:]
    @Published var mealNames: [String]? = nil
    @Published var items: [Date: [[Item]?]] = [:]
    @Published var allowed: [Date: [[Bool]?]] = [:]
    @Published var date: Date = Date()
    public let formatterInternal = DateFormatter()
    public let formatterExternal = DateFormatter()

    init(location: Location) {
        self.location = location
        self.formatterInternal.dateFormat = "yyyy-MM-dd"
        self.formatterExternal.dateFormat = "MMMM d"
        // For testing while we don't have updated data.
        //self.date = self.formatterInternal.date(from: "2020-09-24")!
        self.getMeals()
    }

    func getMeals() {
        // TODO: use self.location?.id
        // TODO: may crash when spamming buttons
        let date = self.date
        if (self.meals[date] == nil) {
            nm.getMeals(locationId: self.location.id,
                        date: self.formatterInternal.string(from: date),
                        completion: { meals in
                self.meals[date] = meals
                self.items[date] = [[Item]?](repeating: nil, count: meals.count)
                self.allowed[date] = [[Bool]?](repeating: nil, count: meals.count)
                // TODO: switch to whatever current/soonest meal is
                self.getItems(date: date, mealIndex: 0)
            })
        }
    }

    func getItems(date: Date, mealIndex: Int) {
        if (
            self.meals[date] != nil &&
            self.items[date] != nil &&
            mealIndex < self.items[date]!.count &&
            self.items[date]![mealIndex] == nil
        ) {
            nm.getItems(mealId: self.meals[date]![mealIndex].id, completion: { items in
                self.allowed[date]![mealIndex] = items.map { item in
                    !(
                        (self.settings.vegetarian && !item.vegetarian) ||
                        (self.settings.vegan && !item.vegan) ||
                        (self.settings.alcohol && item.alcohol) ||
                        (self.settings.nuts && item.nuts) ||
                        (self.settings.shellfish && item.shellfish) ||
                        (self.settings.peanuts && item.peanuts) ||
                        (self.settings.dairy && item.dairy) ||
                        (self.settings.egg && item.egg) ||
                        (self.settings.pork && item.pork) ||
                        (self.settings.fish && item.fish) ||
                        (self.settings.soy && item.soy) ||
                        (self.settings.wheat && item.wheat) ||
                        (self.settings.gluten && item.gluten) ||
                        (self.settings.coconut && item.coconut) ||
                        (self.settings.alcohol && item.alcohol)
                    )
                }
                self.items[date]![mealIndex] = items
            })
        }
    }

    func changeDay(by: Int) {
        self.date = Calendar.current.date(byAdding: .day, value: by, to: self.date)!
        self.getMeals()
    }
}
