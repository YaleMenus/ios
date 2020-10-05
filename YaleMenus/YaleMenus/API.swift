import Foundation

enum API {
    case locations
    case location(id: Int)
    case managers(locationId: Int)
    case meals(locationId: Int)
    case meal(mealId: Int)
    case courses(mealId: Int)
    case course(courseId: Int)
    case items(mealId: Int)
    case item(itemId: Int)
    case nutrition(itemId: Int)
}
