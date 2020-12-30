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
        PushView(destination: ItemView(item: self.item)) {
            HStack {
                Image(self.item.course)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, alignment: .leading)
                Spacer()
                Text(self.item.name)
                    .font(.appBody)
                    .foregroundColor(.foreground)
                Spacer()
            }
            .padding()
            .background(Color.init(red: 241 / 255, green: 244 / 255, blue: 247 / 255))
            .cornerRadius(20)
        }
    }
}

struct LocationView : View {
    @ObservedObject var model: LocationViewModel
    @State private var mealIndex = 0

    init(location: Location) {
        self.model = LocationViewModel(location: location)
    }

    var body: some View {
        VStack {
            HeaderView(text: self.model.location.shortname)
            if (self.model.meals != nil) {
                if (self.model.meals!.isEmpty) {
                    SplashView(iconName: "slash.circle", subtitle: "No meals")
                } else {
                    SegmentedPicker(items: self.model.mealNames!, selection: $mealIndex.onChange(onChange))
                        .padding(.bottom, 14)
                    Text("\(self.model.meals![self.mealIndex].name) hours: \(self.model.meals![self.mealIndex].startTime)-\(self.model.meals![self.mealIndex].endTime)")
                        .font(.appBody)
                        .foregroundColor(.foreground)
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
                }
            } else {
                LoaderView()
            }
            HStack {
                Button(action: {
                    self.changeDay(by: -1)
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
                    self.changeDay(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func onChange(mealIndex: Int) {
        self.model.getItems(mealIndex: mealIndex)
    }

    func changeDay(by: Int) {
        self.mealIndex = 0
        self.model.changeDay(by: by)
    }
}
