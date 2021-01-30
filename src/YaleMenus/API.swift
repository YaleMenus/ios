import Foundation
import Moya

enum API {
    case status
    case halls
    case hall(id: String)
    case managers(hallId: String)
    case meals(hallId: String, date: String)
    case meal(id: Int)
    case items(mealId: Int)
    case item(id: Int)
    case nutrition(itemId: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://yaledine.com/api/")!
    }

    var path: String {
        switch self {
        case .status:
            return "status"
        case .halls:
            return "halls"
        case .hall(let id):
            return "halls/\(id)"
        case .managers(let hallId):
            return "halls/\(hallId)/managers"
        case .meals(let hallId, _):
            return "halls/\(hallId)/meals"
        case .meal(let id):
            return "meals/\(id)"
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
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
