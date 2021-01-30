import SwiftUI
import NavigationStack

struct HallGrid<Content: View>: View {
    let items: [Hall]
    let rows: Int
    let columns: Int
    let content: (Hall?, Int, Int) -> Content

    init(items: [Hall], rows: Int, columns: Int, @ViewBuilder content: @escaping (Hall?, Int, Int) -> Content) {
        self.items = items
        self.rows = rows
        self.columns = columns
        self.content = content
    }

    func item(n: Int) -> Hall? {
        if n <= self.items.count {
            // Offset last element by one for logo
            if n == self.items.count - 1 {
                return nil
            }
            if n > self.items.count - 1 {
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

struct OccupancyBar: View {
    private static let Increment = 7
    private static let RedLimit = 10
    private static let OrangeLimit = 7
    private static let YellowLimit = 5
    private static let GreenLimit = 3
    let occupancy: Int

    init(occupancy: Int) {
        self.occupancy = occupancy
    }

    var body: some View {
        Capsule()
            .fill(Color.transparent)
            .frame(width: CGFloat(OccupancyBar.Increment * OccupancyBar.RedLimit), height: 10)
        .overlay(
            Capsule()
                .fill(Color.red)
                .frame(width: CGFloat(OccupancyBar.Increment * min(OccupancyBar.RedLimit, self.occupancy))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.orange)
                .frame(width: CGFloat(OccupancyBar.Increment * min(OccupancyBar.OrangeLimit, self.occupancy))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.yellow)
                .frame(width: CGFloat(OccupancyBar.Increment * min(OccupancyBar.YellowLimit, self.occupancy))),
            alignment: .leading
        )
        .overlay(
            Capsule()
                .fill(Color.green)
                .frame(width: CGFloat(OccupancyBar.Increment * min(OccupancyBar.GreenLimit, self.occupancy))),
            alignment: .leading
        )
    }
}

struct HallsView: View {
    @ObservedObject var model = HallsViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    @State private var isReloading = false

    var body: some View {
        VStack {
            if self.model.halls != nil {
                HallGrid(items: self.model.halls!, rows: 5, columns: 3) { hall, _, _ in
                    if hall != nil {
                        GeometryReader { geometry in
                            VStack(alignment: .center, spacing: 0) {
                                OccupancyBar(occupancy: hall!.occupancy)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 8, trailing: 0))
                                Image(hall!.id)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: geometry.size.height / 1.7)
                                Text(hall!.nickname)
                                    .font(.appBodyMedium)
                                    .foregroundColor(.mainDesaturated)
                                    .padding(.top, 4)
                            }
                            .opacity(hall!.open ? 1 : 0.5)
                            .frame(width: geometry.size.width)
                        }.onTapGesture {
                            DispatchQueue.main.async {
                                self.navigationStack.push(HallView(hall: hall!))
                            }
                        }
                    } else {
                        VStack {
//                            OccupancyBar(occupancy: 0)
//                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
//                            GeometryReader { geometry in
//                                Image("logo")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(height: geometry.size.height)
//                            }
                            Spacer()
                            Image("gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 30)
                                .padding(.top, 10)
                                .padding(.bottom, -3)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        self.navigationStack.push(SettingsView())
                                    }
                                }
                            Text("Yale Menus")
                                .font(.appTitle)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.mainDesaturated)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }.frame(maxWidth: .infinity)
                    }
                }
            } else {
                Loader()
            }
        }
        .padding(.bottom)
        .alert(isPresented: $model.showAlert) {
            Alert(title: Text(self.model.alertMessage!))
        }
//        .pullToRefresh(isShowing: $isReloading) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.model.load()
//            }
//        }
    }
}
