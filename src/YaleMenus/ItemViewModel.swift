import Foundation

class ItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    let settings = Settings()

    @Published var item: Item
    @Published var nutrition: Nutrition?

    init(item: Item, defaults: UserDefaults = .standard) {
        self.item = item
        if self.settings.showNutrition {
            nm.getNutrition(itemId: self.item.id, completion: { nutrition in
                self.nutrition = nutrition
            })
        }
    }
}
