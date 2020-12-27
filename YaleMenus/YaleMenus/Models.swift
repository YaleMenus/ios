import Foundation

struct Location: Identifiable {
    let id: Int
    let name: String
    let shortname: String
    let code: String
    let isOpen: Bool
    let capacity: Int
    let latitude: Float
    let longitude: Float
    let address: String
    let phone: String
}

extension Location: Decodable {
    enum LocationCodingKeys: String, CodingKey {
        case id
        case name
        case shortname
        case code
        case isOpen = "is_open"
        case capacity
        case latitude
        case longitude
        case address
        case phone
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        shortname = try container.decode(String.self, forKey: .shortname)
        code = try container.decode(String.self, forKey: .code)
        isOpen = try container.decode(Bool.self, forKey: .isOpen)
        capacity = try container.decode(Int.self, forKey: .capacity)
        latitude = try container.decode(Float.self, forKey: .latitude)
        longitude = try container.decode(Float.self, forKey: .longitude)
        address = try container.decode(String.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
    }
}

struct Manager {
    let id: Int
    let name: String
    let email: String
    let position: String
    let locationId: Int
}

extension Manager: Decodable {
    enum ManagerCodingKeys: String, CodingKey {
        case id
        case name
        case email
        case position
        case locationId = "location_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ManagerCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        position = try container.decode(String.self, forKey: .position)
        locationId = try container.decode(Int.self, forKey: .locationId)
    }
}

struct Meal {
    let id: Int
    let name: String
    let date: String
    let startTime: String
    let endTime: String
    let locationId: Int
}

extension Meal: Decodable {
    enum MealCodingKeys: String, CodingKey {
        case id
        case name
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case locationId = "location_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        startTime = try container.decode(String.self, forKey: .startTime)
        endTime = try container.decode(String.self, forKey: .endTime)
        locationId = try container.decode(Int.self, forKey: .locationId)
    }
}

struct Course {
    let id: Int
    let name: String
    let mealId: Int
}

extension Course: Decodable {
    enum CourseCodingKeys: String, CodingKey {
        case id
        case name
        case mealId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CourseCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        mealId = try container.decode(Int.self, forKey: .mealId)
    }
}

struct Item {
    let id: Int
    let name: String
    let ingredients: String
    let vegetarian: Bool
    let vegan: Bool
    let alcohol: Bool
    let nuts: Bool
    let shellfish: Bool
    let peanuts: Bool
    let dairy: Bool
    let egg: Bool
    let pork: Bool
    let fish: Bool
    let soy: Bool
    let wheat: Bool
    let gluten: Bool
    let coconut: Bool
    let mealId: Int
    let courseId: Int
}

extension Item: Decodable {
    enum ItemCodingKeys: String, CodingKey {
        case id
        case name
        case ingredients
        case vegetarian
        case vegan
        case alcohol
        case nuts
        case shellfish
        case peanuts
        case dairy
        case egg
        case pork
        case fish
        case soy
        case wheat
        case gluten
        case coconut
        case mealId = "meal_id"
        case courseId = "course_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        vegetarian = try container.decode(Bool.self, forKey: .vegetarian)
        vegan = try container.decode(Bool.self, forKey: .vegan)
        alcohol = try container.decode(Bool.self, forKey: .alcohol)
        nuts = try container.decode(Bool.self, forKey: .nuts)
        shellfish = try container.decode(Bool.self, forKey: .shellfish)
        peanuts = try container.decode(Bool.self, forKey: .peanuts)
        dairy = try container.decode(Bool.self, forKey: .dairy)
        egg = try container.decode(Bool.self, forKey: .egg)
        pork = try container.decode(Bool.self, forKey: .pork)
        fish = try container.decode(Bool.self, forKey: .fish)
        soy = try container.decode(Bool.self, forKey: .soy)
        wheat = try container.decode(Bool.self, forKey: .wheat)
        gluten = try container.decode(Bool.self, forKey: .gluten)
        coconut = try container.decode(Bool.self, forKey: .coconut)
        mealId = try container.decode(Int.self, forKey: .mealId)
        courseId = try container.decode(Int.self, forKey: .courseId)
    }
}

struct Nutrition {
    let id: Int
    let portionSize: String?
    let calories: String

    let totalFat: String
    let saturatedFat: String
    let transFat: String
    let cholesterol: String
    let sodium: String
    let totalCarbohydrate: String
    let dietaryFiber: String
    let totalSugars: String
    let protein: String
    let vitaminD: String
    let vitaminA: String
    let vitaminC: String
    let calcium: String
    let iron: String
    let potassium: String

    let totalFatPDV: Int
    let saturatedFatPDV: Int
    let transFatPDV: Int?
    let cholesterolPDV: Int
    let sodiumPDV: Int
    let totalCarbohydratePDV: Int
    let dietaryFiberPDV: Int
    let totalSugarsPDV: Int?
    let proteinPDV: Int
    let vitaminDPDV: Int
    let vitaminAPDV: Int
    let vitaminCPDV: Int
    let calciumPDV: Int
    let ironPDV: Int
    let potassiumPDV: Int

    let itemId: Int
}

extension Nutrition: Decodable {
    enum NutritionCodingKeys: String, CodingKey {
        case id
        case portionSize = "portion_size"
        case calories

        case totalFat = "total_fat"
        case saturatedFat = "saturated_fat"
        case transFat = "trans_fat"
        case cholesterol
        case sodium
        case totalCarbohydrate = "total_carbohydrate"
        case dietaryFiber = "dietary_fiber"
        case totalSugars = "total_sugars"
        case protein
        case vitaminD = "vitamin_d"
        case vitaminA = "vitamin_a"
        case vitaminC = "vitamin_c"
        case calcium
        case iron
        case potassium

        case totalFatPDV = "total_fat_pdv"
        case saturatedFatPDV = "saturated_fat_pdv"
        case transFatPDV = "trans_fat_pdv"
        case cholesterolPDV = "cholesterol_pdv"
        case sodiumPDV = "sodium_pdv"
        case totalCarbohydratePDV = "total_carbohydrate_pdv"
        case dietaryFiberPDV = "dietary_fiber_pdv"
        case totalSugarsPDV = "total_sugars_pdv"
        case proteinPDV = "protein_pdv"
        case vitaminDPDV = "vitamin_d_pdv"
        case vitaminAPDV = "vitamin_a_pdv"
        case vitaminCPDV = "vitamin_c_pdv"
        case calciumPDV = "calcium_pdv"
        case ironPDV = "iron_pdv"
        case potassiumPDV = "potassium_pdv"

        case itemId = "item_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NutritionCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        portionSize = try container.decode(String.self, forKey: .portionSize)
        calories = try container.decode(String.self, forKey: .calories)

        totalFat = try container.decode(String.self, forKey: .totalFat)
        saturatedFat = try container.decode(String.self, forKey: .saturatedFat)
        transFat = try container.decode(String.self, forKey: .transFat)
        cholesterol = try container.decode(String.self, forKey: .cholesterol)
        sodium = try container.decode(String.self, forKey: .sodium)
        totalCarbohydrate = try container.decode(String.self, forKey: .totalCarbohydrate)
        dietaryFiber = try container.decode(String.self, forKey: .dietaryFiber)
        totalSugars = try container.decode(String.self, forKey: .totalSugars)
        protein = try container.decode(String.self, forKey: .protein)
        vitaminD = try container.decode(String.self, forKey: .vitaminD)
        vitaminA = try container.decode(String.self, forKey: .vitaminA)
        vitaminC = try container.decode(String.self, forKey: .vitaminC)
        calcium = try container.decode(String.self, forKey: .calcium)
        iron = try container.decode(String.self, forKey: .iron)
        potassium = try container.decode(String.self, forKey: .potassium)

        totalFatPDV = try container.decode(Int.self, forKey: .totalFatPDV)
        saturatedFatPDV = try container.decode(Int.self, forKey: .saturatedFatPDV)
        transFatPDV = try container.decode(Int?.self, forKey: .transFatPDV)
        cholesterolPDV = try container.decode(Int.self, forKey: .cholesterolPDV)
        sodiumPDV = try container.decode(Int.self, forKey: .sodiumPDV)
        totalCarbohydratePDV = try container.decode(Int.self, forKey: .totalCarbohydratePDV)
        dietaryFiberPDV = try container.decode(Int.self, forKey: .dietaryFiberPDV)
        totalSugarsPDV = try container.decode(Int?.self, forKey: .totalSugarsPDV)
        proteinPDV = try container.decode(Int.self, forKey: .proteinPDV)
        vitaminDPDV = try container.decode(Int.self, forKey: .vitaminDPDV)
        vitaminAPDV = try container.decode(Int.self, forKey: .vitaminAPDV)
        vitaminCPDV = try container.decode(Int.self, forKey: .vitaminCPDV)
        calciumPDV = try container.decode(Int.self, forKey: .calciumPDV)
        ironPDV = try container.decode(Int.self, forKey: .ironPDV)
        potassiumPDV = try container.decode(Int.self, forKey: .potassiumPDV)

        itemId = try container.decode(Int.self, forKey: .itemId)
    }
}
