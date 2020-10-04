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
