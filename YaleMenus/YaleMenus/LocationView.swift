import Foundation
import SwiftUI
import NavigationStack

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
        PushView(destination: ItemView(itemId: self.item.id)) {
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
            .background(Color.init(red: 241 / 255, green: 244 / 255, blue: 247 / 255))
            // TODO: rounded border
        }
    }
}

struct LocationView : View {
    @ObservedObject var model: LocationViewModel
    @State private var mealIndex = 0

    init(locationId: Int) {
        self.model = LocationViewModel(locationId: locationId)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(text: self.model.location?.name ?? "")
            if (self.model.location != nil && self.model.meals != nil) {
                // TODO: .onChange is native in iOS 14+, switch once we can ensure that most users will be on 14
                Picker(selection: $mealIndex.onChange(onChange), label: Text("Choose a meal?")) {
                    ForEach(Array(zip(self.model.meals!.indices, self.model.meals!)), id: \.0) { index, meal in
                        Text(meal.name).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Text("\(self.model.meals![self.mealIndex].name) hours: \(self.model.meals![self.mealIndex].startTime)-\(self.model.meals![self.mealIndex].endTime)")
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
            } else {
                LoaderView()
            }
            HStack {
                Button(action: {
                    self.model.changeDay(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                HStack {
                    Image(systemName: "calendar")
                    Text(self.model.formatterExternal.string(from: self.model.date))
                }
                Spacer()
                Button(action: {
                    self.model.changeDay(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
        }.padding()
    }
    
    func onChange(mealIndex: Int) {
        self.model.getItems(mealIndex: mealIndex)
    }
}
