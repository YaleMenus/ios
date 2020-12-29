import SwiftUI

enum CheckboxStyle {
    case x
    case check
}

struct CheckboxView: View {
    var label: String
    var checked: Binding<Bool>
    var style: CheckboxStyle
    
    init(label: String, checked: Binding<Bool>, style: CheckboxStyle = .x) {
        self.label = label
        self.checked = checked
        self.style = style
    }
    
    func toggle() {
        self.checked.wrappedValue = !self.checked.wrappedValue
    }
    
    func getIcon() -> String {
        if (self.checked.wrappedValue) {
            switch (self.style) {
            case .x:
                return "xmark.circle"
            case .check:
                return "checkmark.circle"
            }
        }
        return "circle"
    }
    
    func getColor() -> Color {
        if (self.checked.wrappedValue) {
            switch (self.style) {
            case .x:
                return .red
            case .check:
                return .green
            }
        }
        return .foreground
    }
    
    var body: some View {
        Button(action: toggle) {
            HStack {
                Image(systemName: self.getIcon())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.getColor())
                    .frame(width: 25)
                    .padding(.trailing, 10)
                Text(self.label)
                    .font(.appBody)
                    .foregroundColor(.foreground)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(text: "Settings")
            ScrollView {
                HStack {
                    // TODO: left align more cleanly!
                    Text("Dietary Restrictions")
                        .font(.appTitle)
                        .foregroundColor(.foreground)
                    Spacer()
                }
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
                HStack {
                    // TODO: left align more cleanly!
                    Text("We will gray out any items on the menu screen that Yale Dining has labeled with allergens you select.")
                        .font(.appBody)
                        .foregroundColor(.foreground)
                    Spacer()
                }
                CheckboxView(label: "Show Nutrition Facts", checked: $model.showNutrition, style: .check)
            // TODO: is this still needed?
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding()
    }
}
