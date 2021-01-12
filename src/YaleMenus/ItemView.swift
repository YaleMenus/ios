import Foundation
import SwiftUI
import NavigationStack

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
                .font(.appTitle)
                .foregroundColor(.foreground)
            Spacer()
        }
    }
}

enum NutritionRowStyle {
    case heading
    case main
    case sub
    case plain
}

struct NutritionRowView : View {
    let label: String
    let amount: String?
    let pdv: Int?
    let style: NutritionRowStyle

    init(label: String, amount: String?, pdv: Int?, style: NutritionRowStyle = .main) {
        self.label = label
        self.amount = amount
        self.pdv = pdv
        self.style = style
    }

    var body: some View {
        VStack {
            if (self.amount != nil) {
                Divider()
                HStack {
                    Text(self.label)
                        .font(self.style == .main ? .appBodyBold : .appBody)
                        .foregroundColor(.foreground)
                        .padding(.leading, self.style == .sub ? 25 : 0)
                    if (self.style == .heading) {
                        Spacer()
                        Text(self.amount!)
                            .font(.appBodyBold)
                            .foregroundColor(.foreground)
                    } else {
                        Text(self.amount!)
                            .font(.appBody)
                            .foregroundColor(.foreground)
                        Spacer()
                    }
                    if (self.pdv != nil) {
                        Text("\(self.pdv!)%")
                            .font(self.style != .plain ? .appBodyBold : .appBody)
                            .foregroundColor(.foreground)
                    }
                }
            }
        }
    }
}

struct ItemView : View {
    @ObservedObject var model: ItemViewModel

    init(item: Item) {
        self.model = ItemViewModel(item: item)
    }

    var body: some View {
        VStack {
            HeaderView(text: self.model.item.course)
            if (!self.model.settings.showNutrition || self.model.nutrition != nil) {
                ScrollView {
                    VStack {
                        // TODO: bold and cleanup
                        Text(self.model.item.name)
                            .font(.appTitle)
                            .foregroundColor(.foreground)
                        ParagraphView(text: "Ingredients: \(self.model.item.ingredients)")
                        VStack {
                            Group {
                                if (self.model.item.vegan) { AllergenView(allergen: "vegan") }
                                if (self.model.item.vegetarian) { AllergenView(allergen: "vegetarian") }
                                if (self.model.item.alcohol) { AllergenView(allergen: "alcohol") }
                                if (self.model.item.nuts) { AllergenView(allergen: "nuts") }
                                if (self.model.item.shellfish) { AllergenView(allergen: "shellfish") }
                                if (self.model.item.peanuts) { AllergenView(allergen: "peanuts") }
                                if (self.model.item.dairy) { AllergenView(allergen: "dairy") }
                            }
                            Group {
                                if (self.model.item.egg) { AllergenView(allergen: "egg") }
                                if (self.model.item.pork) { AllergenView(allergen: "pork") }
                                if (self.model.item.fish) { AllergenView(allergen: "fish") }
                                if (self.model.item.soy) { AllergenView(allergen: "soy") }
                                if (self.model.item.wheat) { AllergenView(allergen: "wheat") }
                                if (self.model.item.gluten) { AllergenView(allergen: "gluten") }
                                if (self.model.item.coconut) { AllergenView(allergen: "coconut") }
                            }
                        }.padding(.bottom)
                        if (self.model.settings.showNutrition) {
                            VStack {
                                Text("Nutrition Facts")
                                    .font(.appTitle)
                                    .foregroundColor(.foreground)
                                NutritionRowView(label: "Serving Size", amount: self.model.nutrition!.portionSize, pdv: nil, style: .heading)
                                NutritionRowView(label: "Calories", amount: self.model.nutrition!.calories, pdv: nil, style: .heading)

                                NutritionRowView(label: "Total Fat", amount: self.model.nutrition!.totalFat, pdv: self.model.nutrition!.totalFatPDV, style: .main)
                                NutritionRowView(label: "Saturated Fat", amount: self.model.nutrition!.saturatedFat, pdv: self.model.nutrition!.saturatedFatPDV, style: .sub)
                                NutritionRowView(label: "Trans Fat", amount: self.model.nutrition!.transFat, pdv: self.model.nutrition!.transFatPDV, style: .sub)
                                NutritionRowView(label: "Cholesterol", amount: self.model.nutrition!.cholesterol, pdv: self.model.nutrition!.cholesterolPDV, style: .main)
                                NutritionRowView(label: "Sodium", amount: self.model.nutrition!.sodium, pdv: self.model.nutrition!.sodiumPDV, style: .main)
                                NutritionRowView(label: "Total Carbohydrate", amount: self.model.nutrition!.totalCarbohydrate, pdv: self.model.nutrition!.totalCarbohydratePDV, style: .main)
                                NutritionRowView(label: "Dietary Fiber", amount: self.model.nutrition!.dietaryFiber, pdv: self.model.nutrition!.dietaryFiberPDV, style: .sub)
                            }
                            VStack {
                                NutritionRowView(label: "Total Sugars", amount: self.model.nutrition!.totalSugars, pdv: self.model.nutrition!.totalSugarsPDV, style: .sub)
                                NutritionRowView(label: "Protein", amount: self.model.nutrition!.protein, pdv: self.model.nutrition!.proteinPDV, style: .plain)
                                NutritionRowView(label: "Vitamin D", amount: self.model.nutrition!.vitaminD, pdv: self.model.nutrition!.vitaminDPDV, style: .plain)
                                NutritionRowView(label: "Vitamin A", amount: self.model.nutrition!.vitaminA, pdv: self.model.nutrition!.vitaminAPDV, style: .plain)
                                NutritionRowView(label: "Vitamin C", amount: self.model.nutrition!.vitaminC, pdv: self.model.nutrition!.vitaminCPDV, style: .plain)
                                NutritionRowView(label: "Calcium", amount: self.model.nutrition!.calcium, pdv: self.model.nutrition!.calciumPDV, style: .plain)
                                NutritionRowView(label: "Iron", amount: self.model.nutrition!.iron, pdv: self.model.nutrition!.ironPDV, style: .plain)
                                NutritionRowView(label: "Potassium", amount: self.model.nutrition!.potassium, pdv: self.model.nutrition!.potassiumPDV, style: .plain)
                            }
                        }
                    }
                }
                // TODO: is this still needed?
                .frame(maxWidth: .infinity)
            } else {
                LoaderView()
            }
        }.padding()
    }
}