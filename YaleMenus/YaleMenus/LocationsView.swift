import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct LocationsView : View {
    @ObservedObject var model = LocationsViewModel();
    
    var body: some View {
        VStack {
            if self.model.locations != nil {
                GridStack(rows: 4, columns: 3) { row, col in
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
                List(self.model.locations!) { location in
                    Text(location.name)
                    Text(location.address)
                }
            } else {
                LoaderView()
            }
        }
    }
}
