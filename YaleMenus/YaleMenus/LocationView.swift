import Foundation
import SwiftUI

struct LocationView : View {
    @ObservedObject var model: LocationViewModel

    init(location: Location) {
        self.model = LocationViewModel(location: location)
    }

    var body: some View {
        Text(self.model.location.name)
    }
}
