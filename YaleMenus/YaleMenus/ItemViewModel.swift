import Foundation

class ItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    var itemId: Int? = nil
    @Published var item: Item? = nil
    @Published var nutrition: Nutrition? = nil

    init(itemId: Int) {
        nm.getItem(id: itemId, completion: { item in
            self.item = item
        })
        nm.getNutrition(itemId: itemId, completion: { nutrition in
            self.nutrition = nutrition
        })
        // TODO: we shouldn't need to store this, it should be accessible through self.item and passed when opening view.
        self.itemId = itemId
    }
}
