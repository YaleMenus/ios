import SwiftUI
import NavigationStack

struct HeaderView : View {
    @EnvironmentObject private var navigationStack: NavigationStack
    var text: String
    var location: Location?

    init(text: String, location: Location? = nil) {
        self.text = text
        self.location = location
    }

    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.light)
                .frame(height: 25)
                .onTapGesture {
                    DispatchQueue.main.async {
                        self.navigationStack.pop()
                    }
                }
            Spacer()
            Text(self.text)
                .font(.appHeader)
                .foregroundColor(.foreground)
                .multilineTextAlignment(.center)
                // TODO: find a cleaner way to reduce padding
                .padding(.vertical, -20)
//            if (self.location != nil) {
//                Spacer()
//                Button(action: {
//                    self.navigationStack.push(LocationInfoView(location: self.location!))
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

struct ParagraphView : View {
    let text: String

    init(text: String) {
        self.text = text;
    }

    var body: some View {
        HStack {
            Text(self.text)
                .font(.appBody)
                .foregroundColor(.foreground)
                .lineSpacing(14)
                .padding(.vertical, 15)
            Spacer()
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
struct BackgroundGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Color
                    .clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
}
struct SizeAwareViewModifier: ViewModifier {

    @Binding private var viewSize: CGSize

    init(viewSize: Binding<CGSize>) {
        self._viewSize = viewSize
    }

    func body(content: Content) -> some View {
        content
            .background(BackgroundGeometryReader())
            .onPreferenceChange(SizePreferenceKey.self, perform: { if self.viewSize != $0 { self.viewSize = $0 }})
    }
}

// Code originally sourced from https://medium.com/better-programming/custom-ios-segmented-control-with-swiftui-473b386d0b51

struct SegmentedPicker: View {
    private static let ActiveSegmentColor: Color = .medium
    private static let BackgroundColor: Color = .white
    private static let TextColor: Color = .foreground
    private static let SelectedTextColor: Color = .white

    private static let TextFont: Font = .appBodyMedium
    
    private static let SegmentCornerRadius: CGFloat = 10
    private static let SegmentXPadding: CGFloat = 16
    private static let SegmentYPadding: CGFloat = 6
    private static let PickerPadding: CGFloat = 0
    
    private static let AnimationDuration: Double = 0.2
    
    // Stores the size of a segment, used to create the active segment rect
    @State private var segmentSize: CGSize = .zero
    // Rounded rectangle to denote active segment
    private var activeSegmentView: AnyView {
        // Don't show the active segment until we have initialized the view
        // This is required for `.animation()` to display properly, otherwise the animation will fire on init
        let isInitialized: Bool = segmentSize != .zero
        if !isInitialized { return EmptyView().eraseToAnyView() }
        return
            RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius)
                .foregroundColor(SegmentedPicker.ActiveSegmentColor)
                .frame(width: self.segmentSize.width, height: self.segmentSize.height)
                .offset(x: self.computeActiveSegmentHorizontalOffset(), y: 0)
                .animation(Animation.easeOut(duration: SegmentedPicker.AnimationDuration))
                .eraseToAnyView()
    }
    
    @Binding private var selection: Int
    private let items: [String]
    
    init(items: [String], selection: Binding<Int>) {
        self._selection = selection
        self.items = items
    }
    
    var body: some View {
        // Align the ZStack to the leading edge to make calculating offset on activeSegmentView easier
        ZStack(alignment: .leading) {
            // activeSegmentView indicates the current selection
            self.activeSegmentView
            HStack {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getSegmentView(for: index)
                }
            }
        }
        .padding(SegmentedPicker.PickerPadding)
        .background(SegmentedPicker.BackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: SegmentedPicker.SegmentCornerRadius))
    }

    // Helper method to compute the offset based on the selected index
    private func computeActiveSegmentHorizontalOffset() -> CGFloat {
        CGFloat(self.selection) * (self.segmentSize.width + SegmentedPicker.SegmentXPadding / 2)
    }

    // Get text view for the segment
    private func getSegmentView(for index: Int) -> some View {
        guard index < self.items.count else {
            return EmptyView().eraseToAnyView()
        }
        let isSelected = self.selection == index
        return
            Text(self.items[index])
                // Dark test for selected segment
                .font(SegmentedPicker.TextFont)
                .foregroundColor(isSelected ? SegmentedPicker.SelectedTextColor : SegmentedPicker.TextColor)
                .lineLimit(1)
                .padding(.vertical, SegmentedPicker.SegmentYPadding)
                .padding(.horizontal, SegmentedPicker.SegmentXPadding)
                .frame(minWidth: self.segmentSize.width)
                .modifier(SizeAwareViewModifier(viewSize: self.$segmentSize))
                .onTapGesture { self.onItemTap(index: index) }
                .eraseToAnyView()
    }

    // On tap to change the selection
    private func onItemTap(index: Int) {
        guard index < self.items.count else {
            return
        }
        self.selection = index
    }
}
