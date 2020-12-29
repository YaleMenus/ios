import SwiftUI

struct CheckboxView: View {
    var label: String
    @State var checked: Bool = false
    
    init(label: String, checked: Bool = false) {
        self.label = label
        self.checked = checked
    }
    
    func toggle() {
        self.checked = !self.checked
    }
    
    var body: some View {
        Button(action: toggle) {
            HStack {
                Image(systemName: self.checked ? "xmark.circle": "circle")
                Text(self.label)
            }.frame(maxWidth: .infinity, alignment: .topLeading)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel()
    
    var body: some View {
        VStack {
            HeaderView(text: "Settings")
            ScrollView {
                Text("Dietary Restrictions")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("I cannot eat:")
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Group {
                    CheckboxView(label: "Meat (I'm Vegetarian)")
                    CheckboxView(label: "Animal Products (I'm Vegan)")
                    CheckboxView(label: "Alcohol")
                    CheckboxView(label: "Nuts")
                    CheckboxView(label: "Shellfish")
                    CheckboxView(label: "Peanuts")
                    CheckboxView(label: "Dairy")
                }
                Group {
                    CheckboxView(label: "Egg")
                    CheckboxView(label: "Pork")
                    CheckboxView(label: "Fish")
                    CheckboxView(label: "Soy")
                    CheckboxView(label: "Wheat")
                    CheckboxView(label: "Gluten")
                    CheckboxView(label: "Coconut")
                }
                CheckboxView(label: "Show Nutrition Facts")
            // TODO: is this still needed?
            }.frame(maxWidth: .infinity, alignment: .topLeading)
        }.padding()
    }
}
