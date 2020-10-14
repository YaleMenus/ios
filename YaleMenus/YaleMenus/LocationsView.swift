import SwiftUI

struct GridStack<Content: View>: View {
    let items: [Location]
    let rows: Int
    let columns: Int
    let content: (Location?, Int, Int) -> Content
    
    init(items: [Location], rows: Int, columns: Int, @ViewBuilder content: @escaping (Location?, Int, Int) -> Content) {
        self.items = items
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    func item(n: Int) -> Location? {
        if n < self.items.count {
            return self.items[n];
        }
        return nil;
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach(0 ..< self.rows, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< self.columns, id: \.self) { column in
                            self.content(self.item(n: row * self.rows + column), row, column)
                        }
                    }.frame(width: geometry.size.width)
                }
            }.frame(height: geometry.size.height)
        }
    }
}

struct LocationsView : View {
    @ObservedObject var model = LocationsViewModel();
    
    var body: some View {
        VStack {
            if self.model.locations != nil {
                GridStack(items: self.model.locations!, rows: 4, columns: 3) { location, row, col in
                    if (location != nil) {
                        Image(String(location!.capacity))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(
                                Image(location!.code)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                             )
                        Text(location!.name)
                    } else {
                        Text("Location goes here")
                    }
                }
            } else {
                LoaderView()
            }
        }
    }
}
