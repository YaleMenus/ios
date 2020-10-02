import Foundation
//   let locations = try? newJSONDecoder().decode(Locations.self, from: jsonData)

// MARK: - Location
struct Location: Codable {
    let address: String
    let capacity, id: Int
    let isOpen: Bool
    let latitude, longitude: Double
    let name, phone: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case address, capacity, id
        case isOpen = "is_open"
        case latitude, longitude, name, phone, type
    }
}

enum TypeEnum: String, Codable {
    case residential = "Residential"
}
