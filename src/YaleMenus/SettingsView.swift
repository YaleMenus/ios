import SwiftUI
import NavigationStack

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
        if self.checked.wrappedValue {
            switch self.style {
            case .x:
                return "xmark.circle.fill"
            case .check:
                return "checkmark.circle.fill"
            }
        }
        return "circle"
    }

    func getColor() -> Color {
        if self.checked.wrappedValue {
            switch self.style {
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
    @ObservedObject var settings = Settings()

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(text: "Settings")
            ScrollView {
                CheckboxView(label: "Show Nutrition Facts", checked: $settings.showNutrition, style: .check)
                HStack {
                    // TODO: left align more cleanly!
                    Text("Dietary Restrictions")
                        .font(.appTitle)
                        .foregroundColor(.foreground)
                    Spacer()
                }
                Group {
                    CheckboxView(label: "Meat (I'm Vegetarian)", checked: $settings.meat)
                    CheckboxView(label: "Animal Products (I'm Vegan)", checked: $settings.animalProducts)
                    CheckboxView(label: "Alcohol", checked: $settings.alcohol)
                    CheckboxView(label: "Nuts", checked: $settings.nuts)
                    CheckboxView(label: "Shellfish", checked: $settings.shellfish)
                    CheckboxView(label: "Peanuts", checked: $settings.peanuts)
                    CheckboxView(label: "Dairy", checked: $settings.dairy)
                }
                Group {
                    CheckboxView(label: "Egg", checked: $settings.egg)
                    CheckboxView(label: "Pork", checked: $settings.pork)
                    CheckboxView(label: "Fish", checked: $settings.fish)
                    CheckboxView(label: "Soy", checked: $settings.soy)
                    CheckboxView(label: "Wheat", checked: $settings.wheat)
                    CheckboxView(label: "Gluten", checked: $settings.gluten)
                    CheckboxView(label: "Coconut", checked: $settings.coconut)
                }
                ParagraphView(text: "We will gray out any items on the menu screen that Yale Dining has labeled with allergens you select.")
                Button(action: {
                    // TODO: does this work?
                    UIApplication.shared.open(URL(string: "mailto:yalemenus@gmail.com,erik.boesen@yale.edu?subject=Yale%20Menus%20Feedback")!)
                }) {
                    HStack {
                        Text("Give Feedback")
                            .font(.appBodyBold)
                            .foregroundColor(.foreground)
                        Spacer()
                    }.padding(.vertical, 8)
                }
                .buttonStyle(PlainButtonStyle())
                .font(.appBodyBold)
                PushView(destination: InformationView()) {
                    HStack {
                        Text("Information & License")
                            .font(.appBodyBold)
                            .foregroundColor(.foreground)
                        Spacer()
                    }.padding(.vertical, 8)
                }
            // TODO: is this still needed?
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding()
    }
}
