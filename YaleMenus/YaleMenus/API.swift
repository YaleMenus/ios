import Foundation
import Moya

enum API {
    case locations
    case location(id: Int)
    case managers(locationId: Int)
    case meals(locationId: Int, date: String)
    case meal(id: Int)
    case courses(mealId: Int)
    case course(id: Int)
    case items(mealId: Int)
    case item(id: Int)
    case nutrition(itemId: Int)
}

extension API: TargetType {
    var baseURL: URL { return URL(string: "https://yaledine.com/api/")! }
    
    var path: String {
        switch self {
        case .locations:
            return "locations"
        case .location(let id):
            return "locations/\(id)"
        case .managers(let locationId):
            return "locations/\(locationId)/managers"
        case .meals(let locationId, _):
            return "locations/\(locationId)/meals"
        case .meal(let id):
            return "meals/\(id)"
        case .courses(let locationId):
            return "locations/\(locationId)/courses"
        case .course(let id):
            return "courses/\(id)"
        case .items(let mealId):
            return "meals/\(mealId)/items"
        case .item(let id):
            return "items/\(id)"
        case .nutrition(let itemId):
            return "items/\(itemId)/nutrition"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .meals(_, let date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        default:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString);
        }
    }
    
    var headers: [String : String]? {
        return nil;
    }
}
