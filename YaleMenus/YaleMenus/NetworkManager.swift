import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func getLocations(completion: @escaping ([Location]) -> ());
    func getLocation(id: Int, completion: @escaping (Location) -> ());
    func getManagers(locationId: Int, completion: @escaping ([Manager]) -> ());
    func getMeals(locationId: Int, date: String, completion: @escaping ([Meal]) -> ());
    func getMeal(mealId: Int, completion: @escaping (Meal) -> ());
    func getCourses(mealId: Int, completion: @escaping ([Course]) -> ());
    func getCourse(courseId: Int, completion: @escaping (Course) -> ());
    func getItems(mealId: Int, completion: @escaping ([Item]) -> ());
    func getItem(itemId: Int, completion: @escaping (Item) -> ());
    func getNutrition(itemId: Int, completion: @escaping (Nutrition) -> ());
}

struct NetworkManager {
    fileprivate let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func getLocations(completion: @escaping ([Location]) -> ()) {
        provider.request(.locations) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Location].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getLocation(id: Int, completion: @escaping (Location) -> ()) {
        provider.request(.location(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Location.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getManagers(locationId: Int, completion: @escaping ([Manager]) -> ()) {
        provider.request(.managers(locationId: locationId)) { result in
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
    func getMeals(locationId: Int, date: String, completion: @escaping ([Meal]) -> ()) {
        provider.request(.meals(locationId: locationId, date: date)) { result in
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
    func getMeal(id: Int, completion: @escaping (Meal) -> ()) {
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
    func getCourses(mealId: Int, completion: @escaping ([Course]) -> ()) {
        provider.request(.courses(mealId: mealId)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Course].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getCourse(id: Int, completion: @escaping (Course) -> ()) {
        provider.request(.course(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Course.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getItems(mealId: Int, completion: @escaping ([Item]) -> ()) {
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
    func getItem(id: Int, completion: @escaping (Item) -> ()) {
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
    func getNutrition(itemId: Int, completion: @escaping (Nutrition) -> ()) {
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
