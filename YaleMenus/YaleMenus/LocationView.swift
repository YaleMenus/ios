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

struct ItemPreviewView : View {
    let item: Item

    init(item: Item) {
        self.item = item
    }

    var body: some View {
        HStack {
            Image("entree")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, alignment: .leading)
            Spacer()
            Text(self.item.name)
            Spacer()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 1)
        )
        .background(Color.init(red: 241 / 255, green: 244 / 255, blue: 247 / 255))
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
            VStack(alignment: .leading) {
                if (self.model.location != nil && self.model.meals != nil) {
                    if (self.model.items != nil && self.model.items![self.mealIndex] != nil) {
                        ScrollView {
                            VStack {
                                ForEach(self.model.items![self.mealIndex]!, id: \.id) { item in
                                    ItemPreviewView(item: item)
                                }
                            }
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
            .padding()
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
