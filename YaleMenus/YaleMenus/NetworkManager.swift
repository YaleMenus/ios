import Foundation
import Moya

struct NetworkManager {
    fileprivate let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
}
