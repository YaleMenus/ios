import Foundation

struct Location {
    let id: Int
    let name: String
    let type: String
    let isOpen: Bool
    let capacity: Int
    let latitude: Float
    let longitude: Float
    let address: String
    let phone: String
}

extension Location: Decodable {
    enum LocationCodingKeys: String, CodingKey {
        case id
        case name
        case type
        case isOpen = "is_open"
        case capacity
        case latitude
        case longitude
        case address
        case phone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        isOpen = try container.decode(Bool.self, forKey: .isOpen)
        capacity = try container.decode(Int.self, forKey: .capacity)
        latitude = try container.decode(Float.self, forKey: .latitude)
        longitude = try container.decode(Float.self, forKey: .longitude)
        address = try container.decode(String.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
    }
}

struct Manager {
    let id: Int
    let name: String
    let email: String
    let position: String
    let locationId: Int
}

extension Manager: Decodable {
    enum ManagerCodingKeys: String, CodingKey {
        case id
        case name
        case email
        case position
        case locationId = "location_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ManagerCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        position = try container.decode(String.self, forKey: .position)
        locationId = try container.decode(Int.self, forKey: .locationId)
    }
}

struct Meal {
    let id: Int
    let name: String
    let date: String
    let startTime: String
    let endTime: String
    let locationId: Int
}

extension Meal: Decodable {
    enum MealCodingKeys: String, CodingKey {
        case id
        case name
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case locationId = "location_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        startTime = try container.decode(String.self, forKey: .startTime)
        endTime = try container.decode(String.self, forKey: .endTime)
        locationId = try container.decode(Int.self, forKey: .locationId)
    }
}

struct Course {
    let id: Int
    let name: String
    let mealId: Int
}

extension Course: Decodable {
    enum CourseCodingKeys: String, CodingKey {
        case id
        case name
        case mealId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CourseCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        mealId = try container.decode(Int.self, forKey: .mealId)
    }
}

struct Item {
    let id: Int
    let name: String
    let ingredients: String
    let vegetarian: Bool
    let vegan: Bool
    let alcohol: Bool
    let nuts: Bool
    let shellfish: Bool
    let peanuts: Bool
    let dairy: Bool
    let egg: Bool
    let pork: Bool
    let fish: Bool
    let soy: Bool
    let wheat: Bool
    let gluten: Bool
    let coconut: Bool
    let mealId: Int
    let courseId: Int
}

extension Item: Decodable {
    enum ItemCodingKeys: String, CodingKey {
        case id
        case name
        case ingredients
        case vegetarian
        case vegan
        case alcohol
        case nuts
        case shellfish
        case peanuts
        case dairy
        case egg
        case pork
        case fish
        case soy
        case wheat
        case gluten
        case coconut
        case mealId = "meal_id"
        case courseId = "course_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        vegetarian = try container.decode(Bool.self, forKey: .vegetarian)
        vegan = try container.decode(Bool.self, forKey: .vegan)
        alcohol = try container.decode(Bool.self, forKey: .alcohol)
        nuts = try container.decode(Bool.self, forKey: .nuts)
        shellfish = try container.decode(Bool.self, forKey: .shellfish)
        peanuts = try container.decode(Bool.self, forKey: .peanuts)
        dairy = try container.decode(Bool.self, forKey: .dairy)
        egg = try container.decode(Bool.self, forKey: .egg)
        pork = try container.decode(Bool.self, forKey: .pork)
        fish = try container.decode(Bool.self, forKey: .fish)
        soy = try container.decode(Bool.self, forKey: .soy)
        wheat = try container.decode(Bool.self, forKey: .wheat)
        gluten = try container.decode(Bool.self, forKey: .gluten)
        coconut = try container.decode(Bool.self, forKey: .coconut)
        mealId = try container.decode(Int.self, forKey: .mealId)
        courseId = try container.decode(Int.self, forKey: .courseId)
    }
}
