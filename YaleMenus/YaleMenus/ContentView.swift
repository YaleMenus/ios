import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //LocationsView()
            //LocationView(locationId: 1)
            ItemView(itemId: 2495)
        }.padding()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
