import Foundation
import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(text: "Settings")
            ScrollView {
                ParagraphView(text: "Thanks for choosing Yale Menus! This app was created by Yalies who wanted a more user-friendly way to track menu items, allergens, and crowding in Yale's dining halls.")
                ParagraphView(text: "\"Yale\" and \"Yale University\" are registered trademarks of Yale University. This application is maintained, hosted, and operated independently of Yale University. The statements and informatino containd in this application are not reviewed, approved, or endorsed by Yale.")
                ParagraphView(text: "This app was built by Erik Boesen (Hopper '24) and Eric Foster (Hopper '20), with help from Jaco Malinowski (Hopper '20) and David Foster (Hopper '23).")
            }
        }.padding()
    }
}
