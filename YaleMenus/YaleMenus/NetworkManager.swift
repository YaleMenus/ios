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
}
