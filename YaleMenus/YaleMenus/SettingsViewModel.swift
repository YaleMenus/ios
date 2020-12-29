import Foundation
import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject, Identifiable {
    private enum Keys {
        static let showNutrition = "show_nutrition"

        static let vegetarian = "vegetarian"
        static let vegan = "vegan"

        static let alcohol = "alcohol"
        static let nuts = "nuts"
        static let shellfish = "shellfish"
        static let peanuts = "peanuts"
        static let dairy = "dairy"
        static let egg = "egg"
        static let pork = "pork"
        static let fish = "fish"
        static let soy = "soy"
        static let wheat = "wheat"
        static let gluten = "gluten"
        static let coconut = "coconut"
    }

    let id = UUID()

    private let cancellable: Cancellable
    private let defaults: UserDefaults

    let objectWillChange = PassthroughSubject<Void, Never>()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.showNutrition: true,
            Keys.vegetarian: false,
            Keys.vegan: false,
            Keys.alcohol: false,
            Keys.nuts: false,
            Keys.shellfish: false,
            Keys.peanuts: false,
            Keys.dairy: false,
            Keys.egg: false,
            Keys.pork: false,
            Keys.fish: false,
            Keys.soy: false,
            Keys.wheat: false,
            Keys.gluten: false,
            Keys.coconut: false,
        ])

        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }

    var showNutrition: Bool {
        set { defaults.set(newValue, forKey: Keys.showNutrition) }
        get { defaults.bool(forKey: Keys.showNutrition) }
    }
    var vegetarian: Bool {
        set { defaults.set(newValue, forKey: Keys.vegetarian) }
        get { defaults.bool(forKey: Keys.vegetarian)}
    }
    var vegan: Bool {
        set { defaults.set(newValue, forKey: Keys.vegan) }
        get { defaults.bool(forKey: Keys.vegan)}
    }
    var alcohol: Bool {
        set { defaults.set(newValue, forKey: Keys.alcohol) }
        get { defaults.bool(forKey: Keys.alcohol)}
    }
    var nuts: Bool {
        set { defaults.set(newValue, forKey: Keys.nuts) }
        get { defaults.bool(forKey: Keys.nuts)}
    }
    var shellfish: Bool {
        set { defaults.set(newValue, forKey: Keys.shellfish) }
        get { defaults.bool(forKey: Keys.shellfish)}
    }
    var peanuts: Bool {
        set { defaults.set(newValue, forKey: Keys.peanuts) }
        get { defaults.bool(forKey: Keys.peanuts)}
    }
    var dairy: Bool {
        set { defaults.set(newValue, forKey: Keys.dairy) }
        get { defaults.bool(forKey: Keys.dairy)}
    }
    var egg: Bool {
        set { defaults.set(newValue, forKey: Keys.egg) }
        get { defaults.bool(forKey: Keys.egg)}
    }
    var pork: Bool {
        set { defaults.set(newValue, forKey: Keys.pork) }
        get { defaults.bool(forKey: Keys.pork)}
    }
    var fish: Bool {
        set { defaults.set(newValue, forKey: Keys.fish) }
        get { defaults.bool(forKey: Keys.fish)}
    }
    var soy: Bool {
        set { defaults.set(newValue, forKey: Keys.soy) }
        get { defaults.bool(forKey: Keys.soy)}
    }
    var wheat: Bool {
        set { defaults.set(newValue, forKey: Keys.wheat) }
        get { defaults.bool(forKey: Keys.wheat)}
    }
    var gluten: Bool {
        set { defaults.set(newValue, forKey: Keys.gluten) }
        get { defaults.bool(forKey: Keys.gluten)}
    }
    var coconut: Bool {
        set { defaults.set(newValue, forKey: Keys.coconut) }
        get { defaults.bool(forKey: Keys.coconut)}
    }
}

extension SettingsViewModel {
}
