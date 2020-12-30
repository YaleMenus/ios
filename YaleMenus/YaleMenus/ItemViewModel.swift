import Foundation

class ItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var item: Item
    @Published var nutrition: Nutrition? = nil
    
    private let defaults: UserDefaults
    
    private enum Keys {
        static let showNutrition = "show_nutrition"
    }
    
    var showNutrition: Bool {
        set { defaults.set(newValue, forKey: Keys.showNutrition) }
        get { defaults.bool(forKey: Keys.showNutrition) }
    }

    init(item: Item, defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.item = item
        if (self.showNutrition) {
            nm.getNutrition(itemId: self.item.id, completion: { nutrition in
                self.nutrition = nutrition
            })
        }
    }
}
