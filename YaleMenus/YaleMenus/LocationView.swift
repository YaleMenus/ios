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
    let allowed: Bool
    @EnvironmentObject private var navigationStack: NavigationStack

    init(item: Item, allowed: Bool) {
        self.item = item
        self.allowed = allowed
    }

    func getCourseImage() -> String {
        if self.item.course == "Soup and Salad" {
            if self.item.name.contains("Soup") {
                return "custom_soup"
            }
            if self.item.name.contains("Salad") {
                return "custom_salad"
            }
        }
        return self.item.course
    }

    var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                self.navigationStack.push(ItemView(item: self.item))
            }
        }) {
            HStack {
                Image(self.getCourseImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 60, maxHeight: 60, alignment: .leading)
                Spacer()
                Text(self.item.name)
                    .font(.appBody)
                    .foregroundColor(.foreground)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
            .background(Color.extraLight)
            .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(self.allowed ? 1 : 0.4)
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
            HeaderView(text: self.model.location.shortname, location: self.model.location)
            if (self.model.meals[self.model.date] != nil) {
                if (self.model.meals[self.model.date]!.isEmpty) {
                    SplashView(iconName: self.model.location.code, subtitle: "No menu posted.")
                } else {
                    SegmentedPicker(items: self.model.meals[self.model.date]!.map { $0.name }, selection: $mealIndex.onChange(onChange))
                        .padding(.bottom, 10)
                    Text("\(self.model.meals[self.model.date]![self.mealIndex].name) hours: \(self.model.reformatTime(self.model.meals[self.model.date]![self.mealIndex].startTime))-\(self.model.reformatTime(self.model.meals[self.model.date]![self.mealIndex].endTime))")
                        .font(.appBody)
                        .foregroundColor(.foreground)
                        .padding(.bottom, 4)
                    if (
                        self.model.items[self.model.date] != nil &&
                        self.model.items[self.model.date]![self.mealIndex] != nil &&
                        self.model.allowed[self.model.date]![self.mealIndex] != nil
                    ) {
                        ScrollView {
                            VStack {
                                ForEach(
                                    Array(zip(
                                        self.model.items[self.model.date]![self.mealIndex]!,
                                        self.model.allowed[self.model.date]![self.mealIndex]!
                                    )),
                                    id: \.0.id
                                ) { item, allowed in
                                    ItemPreviewView(item: item, allowed: allowed)
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
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
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
                                .frame(width: 25)
                                .foregroundColor(.foreground)
                            Text(self.model.dateFormatterExternal.string(from: self.model.date))
                                .font(.appBodyMedium)
                                .foregroundColor(.foreground)
                        }
                    }.frame(maxWidth: .infinity)
                }
                Spacer()
                Button(action: {
                    self.changeDay(by: 1)
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                        .foregroundColor(.medium)
                }.buttonStyle(PlainButtonStyle())
            }
            .padding(.top, 5)
            .frame(maxWidth: .infinity)
            if (self.choosingDate) {
                // TODO: use foreground color
                DatePicker(
                    "",
                    selection: $chosenDate,
                    displayedComponents: .date
                )
                .labelsHidden()
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
