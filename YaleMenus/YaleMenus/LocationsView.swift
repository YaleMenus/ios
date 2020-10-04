import SwiftUI
import Foundation

struct LocationsView : View {
    @State var requested: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if self.requested {
                    Button(action: {
                        self.requested = false
                    }) {
                        ButtonContent(text: "Button pressed", color: .green)
                    }
                } else {
                    Button(action: {
                        self.requested = true
                        API.requestAttention(then: { success in
                            self.requested = success
                            if success {
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                    self.requested = false
                                })
                            }
                        })
                    }) {
                        ButtonContent(text: "Press this button")
                    }
                }
            }
            Spacer()
        }
    }
}
