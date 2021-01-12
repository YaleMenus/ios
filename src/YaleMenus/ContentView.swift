import SwiftUI
import NavigationStack

struct ContentView: View {
    var body: some View {
        NavigationStackView {
            LocationsView()
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
