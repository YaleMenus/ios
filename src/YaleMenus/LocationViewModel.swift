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
    public let dateFormatterInternal = DateFormatter()
    public let dateFormatterExternal = DateFormatter()
    public let timeFormatterInternal = DateFormatter()
    public let timeFormatterExternal = DateFormatter()
    
    
    init(location: Location) {
        self.location = location
        self.dateFormatterInternal.dateFormat = "yyyy-MM-dd"
        self.dateFormatterExternal.dateFormat = "MMMM d"
        self.timeFormatterInternal.dateFormat = "HH:mm"
        self.timeFormatterExternal.dateFormat = DateFormatter.dateFormat(fromTemplate: "j:mm",options:0, locale: Locale.current)?.replacingOccurrences(of: " ", with: "")
        // For testing while we don't have updated data.
        //self.date = self.formatterInternal.date(from: "2020-09-24")!
        self.getMeals()
    }

    func getCurrentOrNextMeal() -> Int {
        let today = Date()
        if !Calendar.current.isDate(self.date, inSameDayAs: today) {
            return 0
        }
        let now = self.timeFormatterInternal.string(from: today)
        for (index, meal) in self.meals[self.date].enumerated() {
            if now < meal.end_time {
                return index
            }
        }
    }

    func getMeals() {
        // TODO: use self.location?.id
        // TODO: may crash when spamming buttons
        let date = self.date
        if (self.meals[date] == nil) {
            nm.getMeals(locationId: self.location.id,
                        date: self.dateFormatterInternal.string(from: date),
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
    
    func reformatTime(_ time: String) -> String {
        let read = self.timeFormatterInternal.date(from: time)!
        // TODO: can we lowercase am/pm within the format string?
        return self.timeFormatterExternal.string(from: read).lowercased()
    }
}
