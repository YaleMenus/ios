import SwiftUI
import Foundation

struct LocationsView : View {
    @State var model = LocationsViewModel();
    
    var body: some View {
        List(model.locations, selection: model.openLocation) { location in
            VStack(alignment: .leading) {
                Text(location.name)
                Text(location.address)
            }
        }
    }
}
