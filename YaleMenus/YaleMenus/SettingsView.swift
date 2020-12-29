import SwiftUI

struct CheckboxView: View {
    var label: String
    var checked: Binding<Bool>
    
    init(label: String, checked: Binding<Bool>) {
        self.label = label
        self.checked = checked
    }
    
    func toggle() {
        self.checked.wrappedValue = !self.checked.wrappedValue
    }
    
    var body: some View {
        Button(action: toggle) {
            HStack {
                Image(systemName: self.checked.wrappedValue ? "xmark.circle": "circle")
                Text(self.label)
                    .font(.appBody)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.leading, 5)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(text: "Settings")
            ScrollView {
                Text("Dietary Restrictions")
                    .font(.appTitle)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                Group {
                    CheckboxView(label: "Meat (I'm Vegetarian)", checked: $model.vegetarian)
                    CheckboxView(label: "Animal Products (I'm Vegan)", checked: $model.vegan)
                    CheckboxView(label: "Alcohol", checked: $model.alcohol)
                    CheckboxView(label: "Nuts", checked: $model.nuts)
                    CheckboxView(label: "Shellfish", checked: $model.shellfish)
                    CheckboxView(label: "Peanuts", checked: $model.peanuts)
                    CheckboxView(label: "Dairy", checked: $model.dairy)
                }
                Group {
                    CheckboxView(label: "Egg", checked: $model.egg)
                    CheckboxView(label: "Pork", checked: $model.pork)
                    CheckboxView(label: "Fish", checked: $model.fish)
                    CheckboxView(label: "Soy", checked: $model.soy)
                    CheckboxView(label: "Wheat", checked: $model.wheat)
                    CheckboxView(label: "Gluten", checked: $model.gluten)
                    CheckboxView(label: "Coconut", checked: $model.coconut)
                }
                Text("We will attempt (but cannot guarantee) to gray out any items on the menu screen containing the ingredients you select.")
                    .font(.appBody)
                CheckboxView(label: "Show Nutrition Facts", checked: $model.showNutrition)
            // TODO: is this still needed?
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding()
    }
}
