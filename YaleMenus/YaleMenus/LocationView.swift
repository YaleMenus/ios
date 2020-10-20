import Foundation
import SwiftUI

struct LocationView : View {
    @ObservedObject var model: LocationViewModel

    init(locationId: Int) {
        self.model = LocationViewModel(locationId: locationId)
    }

    var body: some View {
        VStack {
            if (self.model.location != nil) {
                Text(self.model.location!.name)
            } else {
                LoaderView()
            }
        }
    }
}
