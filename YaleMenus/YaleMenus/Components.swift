import SwiftUI

struct ButtonContent : View {
    @State var text: String
    @State var color: Color = .blue
    
    var body: some View {
        Text(self.text)
            .font(.title)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .frame(width: 340, height: 100)
            .background(self.color)
            .cornerRadius(50)
    }
}
