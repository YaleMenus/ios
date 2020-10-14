import SwiftUI

struct LocationsView : View {
    @ObservedObject var model = LocationsViewModel();
    
    var body: some View {
        VStack {
            if self.model.locations != nil {
                List(self.model.locations!) { location in
                    Text(location.name as String)
                    Text(location.address as String)
                }
            } else {
                LoaderView()
            }
        }
    }
}
