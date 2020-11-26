import Foundation
import SwiftUI

struct AllergenView : View {
    let allergen: String

    init(allergen: String) {
        self.allergen = allergen
    }
    
    var body: some View {
         HStack {
           Image("entree")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 60, alignment: .leading)
           Spacer()
           Text(self.allergen)
           Spacer()
       }
    }
}

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
