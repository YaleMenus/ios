import Foundation
import Moya

enum API {
    case locations
    case location(id: Int)
    case managers(locationId: Int)
    case meals(locationId: Int, date: String)
    case meal(mealId: Int)
    case courses(mealId: Int)
    case course(courseId: Int)
    case items(mealId: Int)
    case item(itemId: Int)
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
        case .meal(let mealId):
            return "meals/\(mealId)"
        case .courses(let locationId):
            return "locations/\(locationId)/courses"
        case .course(let courseId):
            return "courses/\(courseId)"
        case .items(let mealId):
            return "meals/\(mealId)/items"
        case .item(let itemId):
            return "items/\(itemId)"
        case .nutrition(let itemId):
            return "items/\(itemId)/nutrition"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.queryString);
    }
    
    var headers: [String : String]? {
        return nil;
    }

    var parameters: [String: String]? {
        switch self {
        case .meals(_, let date):
            return ["date": date]
        default:
            return nil;
        }
    }
}
