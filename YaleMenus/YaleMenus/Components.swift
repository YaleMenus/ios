import SwiftUI

struct HeaderView : View {
    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        Text(self.text)
            .font(.largeTitle)
            .frame(alignment: .trailing)
    }
}
