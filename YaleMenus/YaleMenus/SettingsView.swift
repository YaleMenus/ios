import SwiftUI

struct CheckboxView: View {
    var label: String
    
    init(label: String) {
        
    }
    
    var body: some View {
        HStack {
            
        }
    }
}

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel()
    
    var body: some View {
        VStack {
        HeaderView(text: "Settings")
        ScrollView {
            VStack {
                Text("Dietary Restrictions")
                    .font(.title)
                VStack {
                    
                }
            }
        // TODO: is this still needed?
        }.frame(maxWidth: .infinity)
    }
}
