import SwiftUI
import NavigationStack

struct HeaderView : View {
    @EnvironmentObject private var navigationStack: NavigationStack
    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
            .onTapGesture {
                DispatchQueue.main.async {
                    self.navigationStack.pop()
                }
            }
            Spacer()
            Text(self.text)
                .font(.largeTitle)
                .frame(alignment: .trailing)
        }
    }
}
