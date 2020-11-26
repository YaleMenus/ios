import Foundation
import SwiftUI

struct AllergenView : View {
    let allergen: String

    init(allergen: String) {
        self.allergen = allergen
    }
    
    func capitalize(string: String) -> String {
        return string.prefix(1).capitalized + string.dropFirst()
    }

    var body: some View {
         HStack {
            Image(self.allergen)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 60, alignment: .leading)
            Text(self.capitalize(string: self.allergen))
            Spacer()
       }
    }
}

struct ItemView : View {
    @ObservedObject var model: ItemViewModel

    init(itemId: Int) {
        self.model = ItemViewModel(itemId: itemId)
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                Spacer()
                HeaderView(text: self.model.item?.name ?? "")
            }
            if (self.model.item != nil) {
                VStack {
                    if (self.model.item!.alcohol) { AllergenView(allergen: "alcohol") }
                    if (self.model.item!.nuts) { AllergenView(allergen: "nuts") }
                    if (self.model.item!.shellfish) { AllergenView(allergen: "shellfish") }
                    if (self.model.item!.peanuts) { AllergenView(allergen: "peanuts") }
                    if (self.model.item!.dairy) { AllergenView(allergen: "dairy") }
                    if (self.model.item!.egg) { AllergenView(allergen: "egg") }
                    if (self.model.item!.pork) { AllergenView(allergen: "pork") }
                    if (self.model.item!.fish) { AllergenView(allergen: "fish") }
                    if (self.model.item!.soy) { AllergenView(allergen: "soy") }
                    // TODO: why does uncommenting these break things??
//                    if (self.model.item!.wheat) { AllergenView(allergen: "wheat") }
//                    if (self.model.item!.gluten) { AllergenView(allergen: "gluten") }
//                    if (self.model.item!.coconut) { AllergenView(allergen: "coconut") }
                    Text("Ingredients: " + self.model.item!.ingredients)
                }
            } else {
                LoaderView()
            }
        }.padding()
    }
}
