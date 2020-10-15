import SwiftUI

struct LocationGrid<Content: View>: View {
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
        if n <= self.items.count {
            // Offset last element by one for logo
            if (n == self.items.count - 1) {
                return nil
            }
            if (n == self.items.count) {
                return self.items[n - 1]
            }
            return self.items[n]
        }
        return nil
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach(0 ..< self.rows, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< self.columns, id: \.self) { column in
                            self.content(self.item(n: row * self.columns + column), row, column)
                        }
                    }.frame(width: geometry.size.width)
                }
            }.frame(height: geometry.size.height)
        }
    }
}

struct CapacityBar : View {
    let INCREMENT = 8
    let RED_LIMIT = 10
    let ORANGE_LIMIT = 7
    let YELLOW_LIMIT = 5
    let GREEN_LIMIT = 3
    let capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(width: CGFloat(INCREMENT * RED_LIMIT), height: 10)
        .overlay(
            Capsule()
                .fill(Color.red)
                .frame(width: CGFloat(INCREMENT * min(RED_LIMIT, self.capacity))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.orange)
                .frame(width: CGFloat(INCREMENT * min(ORANGE_LIMIT, self.capacity))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.yellow)
                .frame(width: CGFloat(INCREMENT * min(YELLOW_LIMIT, self.capacity))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.green)
                .frame(width: CGFloat(INCREMENT * min(GREEN_LIMIT, self.capacity))),
            alignment: .leading
        )
    }
}

struct LocationsView : View {
    @ObservedObject var model = LocationsViewModel()
    
    var body: some View {
        VStack {
            if self.model.locations != nil {
                LocationGrid(items: self.model.locations!, rows: 5, columns: 3) { location, row, col in
                    GeometryReader { geometry in
                        if (location != nil) {
                            VStack(alignment: .center) {
                                CapacityBar(capacity: location!.capacity)
                                Image(location!.code)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.width / 1.2)
                                Text(location!.shortName())
                                    .font(.system(.body, design: .rounded))
                            }.frame(width: geometry.size.width)
                        } else {
                            VStack {
                                Image("icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top)
                            }
                        }
                    }
                }
            } else {
                LoaderView()
            }
        }
    }
}
