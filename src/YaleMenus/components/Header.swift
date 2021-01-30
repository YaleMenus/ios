import SwiftUI
import NavigationStack

struct Header: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    var text: String
    var hall: Hall?

    init(text: String, hall: Hall? = nil) {
        self.text = text
        self.hall = hall
    }

    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.faint)
                .frame(height: 25)
                .onTapGesture {
                    DispatchQueue.main.async {
                        self.navigationStack.pop()
                    }
                }
            Spacer()
            Text(self.text)
                .font(self.text.count <= 10 ? .appHeader : .appHeaderSmall)
                .foregroundColor(.main)
                .multilineTextAlignment(.trailing)
                // TODO: find a cleaner way to reduce padding
                .padding(.vertical, 5)
//            if (self.hall != nil) {
//                Spacer()
//                Button(action: {
//                    self.navigationStack.push(HallInfoView(hall: self.hall!))
//                }) {
//                    Image(systemName: "info.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(.light)
//                        .frame(height: 25)
//                }.buttonStyle(PlainButtonStyle())
//            }
        }
    }
}
