import Foundation
import SwiftUI

struct LocationInfoView : View {
    @ObservedObject var model: LocationViewModel

    init(location: Location) {
        self.model = LocationViewModel(location: location)
    }
    
    var body: some View {
        VStack {
            HeaderView(text: self.model.location.shortname)
            VStack {
                Text("Name: ").font(.appBodyMedium) + Text(self.model.location.name)
            }
        }
    }
}
