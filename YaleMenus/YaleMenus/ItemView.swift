import Foundation
import SwiftUI

struct ItemView : View {
    @ObservedObject var model: ItemViewModel

    init(itemId: Int) {
        self.model = ItemViewModel(itemId: itemId)
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                Spacer()
                HeaderView(text: self.model.item?.name ?? "")
            }
            if (self.model.item != nil) {
                VStack {
                    
                    Text(self.model.item!.ingredients)
                }
            } else {
                LoaderView()
            }
        }.padding()
    }
}
