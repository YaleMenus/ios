import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func getHalls(completion: @escaping ([Hall]) -> Void)
    func getHall(id: String, completion: @escaping (Hall) -> Void)
    func getManagers(hallId: String, completion: @escaping ([Manager]) -> Void)
    func getMeals(hallId: String, date: String, completion: @escaping ([Meal]) -> Void)
    func getMeal(mealId: Int, completion: @escaping (Meal) -> Void)
    func getItems(mealId: Int, completion: @escaping ([Item]) -> Void)
    func getItem(itemId: Int, completion: @escaping (Item) -> Void)
    func getNutrition(itemId: Int, completion: @escaping (Nutrition) -> Void)
}

struct NetworkManager {
    fileprivate let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

    func getHalls(completion: @escaping ([Hall]) -> Void) {
        provider.request(.halls) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Hall].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getHall(id: String, completion: @escaping (Hall) -> Void) {
        provider.request(.hall(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Hall.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getManagers(hallId: String, completion: @escaping ([Manager]) -> Void) {
        provider.request(.managers(hallId: hallId)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Manager].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getMeals(hallId: String, date: String, completion: @escaping ([Meal]) -> Void) {
        provider.request(.meals(hallId: hallId, date: date)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Meal].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getMeal(id: Int, completion: @escaping (Meal) -> Void) {
        provider.request(.meal(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Meal.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getItems(mealId: Int, completion: @escaping ([Item]) -> Void) {
        provider.request(.items(mealId: mealId)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Item].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getItem(id: Int, completion: @escaping (Item) -> Void) {
        provider.request(.item(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Item.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getNutrition(itemId: Int, completion: @escaping (Nutrition) -> Void) {
        provider.request(.nutrition(itemId: itemId)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Nutrition.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
