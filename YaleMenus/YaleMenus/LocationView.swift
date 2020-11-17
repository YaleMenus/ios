import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct LocationView : View {
    @ObservedObject var model: LocationViewModel
    @State private var mealIndex = 0

    init(locationId: Int) {
        self.model = LocationViewModel(locationId: locationId)
    }

    var body: some View {
        NavigationView {
            VStack {
                if (self.model.location != nil && self.model.meals != nil) {
                    if (self.model.items != nil && self.model.items![self.mealIndex] != nil) {
                        ForEach(self.model.items![self.mealIndex]!, id: \.id) { item in
                            Text(item.name)
                        }
                    } else {
                        LoaderView()
                    }
                    // TODO: .onChange is native in iOS 14+, switch once we can ensure that most users will be on 14
                    Picker(selection: $mealIndex.onChange(onChange), label: Text("Choose a meal?")) {
                        ForEach(Array(zip(self.model.meals!.indices, self.model.meals!)), id: \.0) { index, meal in
                            Text(meal.name).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                } else {
                    LoaderView()
                }
            }
            .navigationBarTitle(self.model.location?.name ?? "")
            .navigationBarItems(leading:
                HStack {
                    Image(systemName: "chevron.left")
                    Button("Back") {
                        print("Back tapped!")
                    }
                }
            )
        }
    }
    
    func onChange(mealIndex: Int) {
        self.model.getItems(mealIndex: mealIndex)
    }
}
