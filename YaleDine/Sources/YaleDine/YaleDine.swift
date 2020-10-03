import Foundation
import Alamofire

struct YaleDine {
    static let API_ROOT = "https://yaledine.com/api/"

    static func get(endpoint: String, type: TypeEnum, then: @escaping (Any) -> Void) {
        AF.request(self.API_ROOT + endpoint, method: .get)
        .responseJSON { response in
            then(response)
        }
    }

    static func getLocations(then: @escaping ([Location]) -> Void) {
        return self.get(endpoint: "locations", type: [Location], then: then)
    }
    
    static func getLocation(id: Int, then: @escaping (Location?) -> Void) {
        return self.get(endpoint: "locations/\(id)", type: Location, then: then)
    }

//    /locations
//    /locations/:id
//    /locations/:id/managers
//    /locations/:id/meals
//    /meals/:id
//    /meals/:id/items
//    /meals/:id/courses
//    /courses/:id
//    /courses/:id/items
//    /items/:id
//    /items/:id/nutrition
}
