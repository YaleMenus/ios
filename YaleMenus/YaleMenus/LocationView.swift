import Foundation
import SwiftUI

struct LocationView : View {
    @ObservedObject var model: LocationViewModel
    @State private var mealIndex = 0

    init(locationId: Int) {
        self.model = LocationViewModel(locationId: locationId)
    }

    var body: some View {
        VStack {
//            if (self.model.location != nil) {
//                Text(self.model.location!.name)
//            }
            if (self.model.meals != nil) {
                Picker(selection: $mealIndex, label: Text("Choose a meal?")) {
                    ForEach(Array(zip(self.model.meals!.indices, self.model.meals!)), id: \.0) { index, meal in
                        Text(meal.name).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            } else {
                LoaderView()
            }
        }
    }
}
