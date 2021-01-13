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
            if n == self.items.count {
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

struct CapacityBar: View {
    private static let Increment = 7
    private static let RedLimit = 10
    private static let OrangeLimit = 7
    private static let YellowLimit = 5
    private static let GreenLimit = 3
    let capacity: Int

    init(capacity: Int) {
        self.capacity = capacity
    }

    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(width: CGFloat(CapacityBar.Increment * CapacityBar.RedLimit), height: 10)
        .overlay(
            Capsule()
                .fill(Color.red)
                .frame(width: CGFloat(CapacityBar.Increment * min(CapacityBar.RedLimit, self.capacity))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.orange)
                .frame(width: CGFloat(CapacityBar.Increment * min(CapacityBar.OrangeLimit, self.capacity))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.yellow)
                .frame(width: CGFloat(CapacityBar.Increment * min(CapacityBar.YellowLimit, self.capacity))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.green)
                .frame(width: CGFloat(CapacityBar.Increment * min(CapacityBar.GreenLimit, self.capacity))),
            alignment: .leading
        )
    }
}

struct LocationsView: View {
    @ObservedObject var model = LocationsViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    @State private var isReloading = false

    var body: some View {
        VStack {
            if self.model.locations != nil {
                LocationGrid(items: self.model.locations!, rows: 5, columns: 3) { location, _, _ in
                    if location != nil {
                        GeometryReader { geometry in
                            VStack(alignment: .center, spacing: 0) {
                                CapacityBar(capacity: location!.capacity)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 8, trailing: 0))
                                Image(location!.code)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.height / 1.7)
                                Text(location!.shortname)
                                    .font(.appBody)
                                    .foregroundColor(.appBlack)
                                    .padding(.top, 4)
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
//                            CapacityBar(capacity: 0)
//                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
//                            GeometryReader { geometry in
//                                Image("logo")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(height: geometry.size.height)
//                            }
                            Text("Yale Menus")
                                .font(.appTitle)
                                .foregroundColor(.appBlack)
                                .padding(.bottom, -6)
                                .multilineTextAlignment(.center)
                            Image("gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 30)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        self.navigationStack.push(SettingsView())
                                    }
                                }
                        }.frame(maxWidth: .infinity)
                    }
                }
            } else {
                LoaderView()
            }
        }
//        .pullToRefresh(isShowing: $isReloading) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.model.load()
//            }
//        }
    }
}
