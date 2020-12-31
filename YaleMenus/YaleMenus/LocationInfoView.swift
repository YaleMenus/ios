import Foundation
import SwiftUI

struct LocationInfoView : View {
    @ObservedObject var model: LocationInfoViewModel

    init(location: Location) {
        self.model = LocationInfoViewModel(location: location)
    }
    
    var body: some View {
        VStack {
            HeaderView(text: self.model.location.shortname)
            if (self.model.managers != nil) {
                VStack {
                    Text("Name: ").font(.appBodyMedium) + Text(self.model.location.name)
                }
            } else {
                LoaderView()
            }
        }.padding()
    }
}
