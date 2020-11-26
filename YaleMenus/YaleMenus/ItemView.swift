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

struct NutritionRowView : View {
    let label: String
    let amount: String
    let pdv: Int?
    let offset: Int

    init(label: String, amount: String, pdv: Int?, offset: Int = 0) {
        self.label = label
        self.amount = amount
        self.pdv = pdv
        self.offset = offset
    }

    var body: some View {
        HStack {
            Text(self.label)
            Text(self.amount)
            Spacer()
            if (self.pdv != nil) { Text("\(self.pdv!)%") }
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
                if (self.model.nutrition != nil) {
                    Text("Nutrition Facts")
                    HStack {
                        Text("Serving Size")
                        Spacer()
                        Text(self.model.nutrition!.portionSize)
                    }
                    HStack {
                        Text("Calories")
                        Spacer()
                        Text(self.model.nutrition!.calories)
                    }
                    NutritionRowView(label: "Total Fat", amount: self.model.nutrition!.totalFat, pdv: self.model.nutrition!.totalFatPDV)
                    NutritionRowView(label: "Saturated Fat", amount: self.model.nutrition!.saturatedFat, pdv: self.model.nutrition!.saturatedFatPDV)
                    NutritionRowView(label: "Trans Fat", amount: self.model.nutrition!.transFat, pdv: self.model.nutrition!.transFatPDV)
                    NutritionRowView(label: "Cholesterol", amount: self.model.nutrition!.cholesterol, pdv: self.model.nutrition!.cholesterolPDV)
                    NutritionRowView(label: "Sodium", amount: self.model.nutrition!.sodium, pdv: self.model.nutrition!.sodiumPDV)
                    NutritionRowView(label: "Total Carbohydrate", amount: self.model.nutrition!.totalCarbohydrate, pdv: self.model.nutrition!.totalCarbohydratePDV)
                    NutritionRowView(label: "Dietary Fiber", amount: self.model.nutrition!.dietaryFiber, pdv: self.model.nutrition!.dietaryFiberPDV)
//                    NutritionRowView(label: "Total Sugars", amount: self.model.nutrition!.totalSugars, pdv: self.model.nutrition!.totalSugarsPDV)
//                    NutritionRowView(label: "Protein", amount: self.model.nutrition!.protein, pdv: self.model.nutrition!.proteinPDV)
//                    NutritionRowView(label: "Vitamin D", amount: self.model.nutrition!.vitaminD, pdv: self.model.nutrition!.vitaminDPDV)
//                    NutritionRowView(label: "Vitamin A", amount: self.model.nutrition!.vitamonA, pdv: self.model.nutrition!.vitamonAPDV)
//                    NutritionRowView(label: "Vitamin C", amount: self.model.nutrition!.vitamonC, pdv: self.model.nutrition!.vitamonCPDV)
//                    NutritionRowView(label: "Calcium", amount: self.model.nutrition!.calcium, pdv: self.model.nutrition!.calciumPDV)
//                    NutritionRowView(label: "Iron", amount: self.model.nutrition!.iron, pdv: self.model.nutrition!.ironPDV)
//                    NutritionRowView(label: "Potassium", amount: self.model.nutrition!.potassium, pdv: self.model.nutrition!.potassiumPDV)
                } else {
                    LoaderView()
                }
            } else {
                LoaderView()
            }
        }.padding()
    }
}
