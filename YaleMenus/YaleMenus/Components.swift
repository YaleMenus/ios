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
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.medium)
            .frame(height: 25)
            .onTapGesture {
                DispatchQueue.main.async {
                    self.navigationStack.pop()
                }
            }
            Spacer()
            Text(self.text)
                .font(.appHeader)
                .foregroundColor(.foreground)
                // TODO: find a cleaner way to reduce padding
                .padding(.vertical, -20)
                .frame(alignment: .trailing)
        }
    }
}

struct ParagraphView : View {
    let text: String

    init(text: String) {
        self.text = text;
    }

    var body: some View {
        HStack {
            Text(self.text)
                .font(.appBody)
                .foregroundColor(.foreground)
                .lineSpacing(14)
                .padding(.vertical, 15)
            Spacer()
        }
    }
}
