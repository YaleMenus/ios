import Foundation

class ItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var item: Item
    @Published var nutrition: Nutrition? = nil

    init(item: Item) {
        self.item = item
        nm.getNutrition(itemId: self.item.id, completion: { nutrition in
            self.nutrition = nutrition
        })
    }
}
