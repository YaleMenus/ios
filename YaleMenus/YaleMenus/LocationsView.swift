import SwiftUI
import NavigationStack

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
            if (n == self.items.count) {
                return nil
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
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        VStack {
            if self.model.locations != nil {
                LocationGrid(items: self.model.locations!, rows: 5, columns: 3) { location, row, col in
                    if (location != nil) {
                        GeometryReader { geometry in
                            VStack(alignment: .center, spacing: 0) {
                                CapacityBar(capacity: location!.capacity)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 8, trailing: 0))
                                Image(location!.code)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.height / 1.7)
                                Text(location!.shortname)
                                    .font(.appBody)
                                    .padding(.top, 5)
                            }
                            .opacity(location!.isOpen ? 1 : 0.5)
                            .frame(width: geometry.size.width)
                        }.onTapGesture {
                            DispatchQueue.main.async {
                                self.navigationStack.push(LocationView(location: location!))
                            }
                        }
                    } else {
                        VStack {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .padding(EdgeInsets(top: 35, leading: 0, bottom: 0, trailing: 0))
                            Image(systemName: "gear")
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        self.navigationStack.push(SettingsView())
                                    }
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
