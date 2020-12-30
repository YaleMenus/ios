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
            .background(Color.extraLight)
            .cornerRadius(20)
        }
    }
}

struct LocationView : View {
    @ObservedObject var model: LocationViewModel
    @State private var mealIndex = 0
    @State private var choosingDate = false
    @State private var chosenDate = Date()

    init(location: Location) {
        self.model = LocationViewModel(location: location)
    }

    func openDatePicker() {
        self.chosenDate = self.model.date
        self.choosingDate = true
    }

    func closeDatePicker() {
        self.model.date = self.chosenDate
        self.model.getMeals()
        self.choosingDate = false
    }

    var body: some View {
        VStack {
            HeaderView(text: self.model.location.shortname)
            if (self.model.meals[self.model.date] != nil) {
                if (self.model.meals[self.model.date]!.isEmpty) {
                    SplashView(iconName: "slash.circle", subtitle: "No meals on this date")
                } else {
                    SegmentedPicker(items: self.model.meals[self.model.date]!.map { $0.name }, selection: $mealIndex.onChange(onChange))
                        .padding(.bottom, 14)
                    Text("\(self.model.meals[self.model.date]![self.mealIndex].name) hours: \(self.model.meals[self.model.date]![self.mealIndex].startTime)-\(self.model.meals[self.model.date]![self.mealIndex].endTime)")
                        .font(.appBody)
                        .foregroundColor(.foreground)
                    if (self.model.items[self.model.date] != nil && self.model.items[self.model.date]![self.mealIndex] != nil) {
                        ScrollView {
                            VStack {
                                ForEach(self.model.items[self.model.date]![self.mealIndex]!, id: \.id) { item in
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
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .foregroundColor(.medium)
                }.buttonStyle(PlainButtonStyle())
                Spacer()
                if (self.choosingDate) {
                    Button(action: { self.closeDatePicker() }) {
                        Text("Done")
                            .font(.appBodyMedium)
                            .foregroundColor(.foreground)
                    }.buttonStyle(PlainButtonStyle())
                } else {
                    Button(action: { self.openDatePicker() }) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.foreground)
                            Text(self.model.formatterExternal.string(from: self.model.date))
                                .font(.appBodyMedium)
                                .foregroundColor(.foreground)
                        }
                    }
                }
                Spacer()
                Button(action: {
                    self.changeDay(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .foregroundColor(.medium)
                }.buttonStyle(PlainButtonStyle())
            }
            if (self.choosingDate) {
                DatePicker(
                    "",
                    selection: $chosenDate,
                    displayedComponents: [.date]
                )
                // TODO: use this once iOS 14 is more widespread!
                //.datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }
    
    func onChange(mealIndex: Int) {
        self.mealIndex = mealIndex
        self.model.getItems(date: self.model.date, mealIndex: mealIndex)
    }

    func changeDay(by: Int) {
        self.mealIndex = 0
        self.model.changeDay(by: by)
    }
}
