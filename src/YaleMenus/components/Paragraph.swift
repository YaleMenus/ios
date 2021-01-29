import SwiftUI


struct Paragraph: View {
    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        HStack {
            Text(self.text)
                .font(.appBody)
                .foregroundColor(.main)
                .lineSpacing(14)
                .padding(.vertical, 15)
            Spacer()
        }
    }
}
