import Foundation
import SwiftUI
import Combine

final class Settings: ObservableObject, Identifiable {
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
            Keys.coconut: false
        ])

        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }

    var showNutrition: Bool {
        get { defaults.bool(forKey: Keys.showNutrition) }
        set { defaults.set(newValue, forKey: Keys.showNutrition) }
    }
    var vegetarian: Bool {
        get { defaults.bool(forKey: Keys.vegetarian)}
        set { defaults.set(newValue, forKey: Keys.vegetarian) }
    }
    var vegan: Bool {
        get { defaults.bool(forKey: Keys.vegan)}
        set { defaults.set(newValue, forKey: Keys.vegan) }
    }
    var alcohol: Bool {
        get { defaults.bool(forKey: Keys.alcohol)}
        set { defaults.set(newValue, forKey: Keys.alcohol) }
    }
    var nuts: Bool {
        get { defaults.bool(forKey: Keys.nuts)}
        set { defaults.set(newValue, forKey: Keys.nuts) }
    }
    var shellfish: Bool {
        get { defaults.bool(forKey: Keys.shellfish)}
        set { defaults.set(newValue, forKey: Keys.shellfish) }
    }
    var peanuts: Bool {
        get { defaults.bool(forKey: Keys.peanuts)}
        set { defaults.set(newValue, forKey: Keys.peanuts) }
    }
    var dairy: Bool {
        get { defaults.bool(forKey: Keys.dairy)}
        set { defaults.set(newValue, forKey: Keys.dairy) }
    }
    var egg: Bool {
        get { defaults.bool(forKey: Keys.egg)}
        set { defaults.set(newValue, forKey: Keys.egg) }
    }
    var pork: Bool {
        get { defaults.bool(forKey: Keys.pork)}
        set { defaults.set(newValue, forKey: Keys.egg) }
    }
    var fish: Bool {
        get { defaults.bool(forKey: Keys.fish)}
        set { defaults.set(newValue, forKey: Keys.fish) }
    }
    var soy: Bool {
        get { defaults.bool(forKey: Keys.soy)}
        set { defaults.set(newValue, forKey: Keys.soy) }
    }
    var wheat: Bool {
        get { defaults.bool(forKey: Keys.wheat)}
        set { defaults.set(newValue, forKey: Keys.wheat) }
    }
    var gluten: Bool {
        get { defaults.bool(forKey: Keys.gluten)}
        set { defaults.set(newValue, forKey: Keys.gluten) }
    }
    var coconut: Bool {
        get { defaults.bool(forKey: Keys.coconut)}
        set { defaults.set(newValue, forKey: Keys.coconut) }
    }
}
