import Foundation

struct Status {
    let message: String?
    let minVersion: Int?
}

extension Status: Decodable {
    enum StatusCodingKeys: String, CodingKey {
        case message
        case minVersion = "min_version"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatusCodingKeys.self)

        message = try container.decode(String?.self, forKey: .message)
        minVersion = try container.decode(Int?.self, forKey: .minVersion)
    }
}

struct Hall: Identifiable {
    let id: String
    let name: String
    let nickname: String
    let open: Bool
    let occupancy: Int
    let latitude: Float
    let longitude: Float
    let address: String
    let phone: String
}

extension Hall: Decodable {
    enum HallCodingKeys: String, CodingKey {
        case id
        case name
        case nickname
        case open
        case occupancy
        case latitude
        case longitude
        case address
        case phone
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HallCodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nickname = try container.decode(String.self, forKey: .nickname)
        open = try container.decode(Bool.self, forKey: .open)
        occupancy = try container.decode(Int.self, forKey: .occupancy)
        latitude = try container.decode(Float.self, forKey: .latitude)
        longitude = try container.decode(Float.self, forKey: .longitude)
        address = try container.decode(String.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
    }
}

struct Manager {
    let id: Int
    let name: String
    let email: String?
    let position: String?
}

extension Manager: Decodable {
    enum ManagerCodingKeys: String, CodingKey {
        case id
        case name
        case email
        case position
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ManagerCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String?.self, forKey: .email)
        position = try container.decode(String?.self, forKey: .position)
    }
}

struct Meal {
    let id: Int
    let name: String
    let date: String
    let startTime: String
    let endTime: String
    let hallId: String
}

extension Meal: Decodable {
    enum MealCodingKeys: String, CodingKey {
        case id
        case name
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case hallId = "hall_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MealCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        startTime = try container.decode(String.self, forKey: .startTime)
        endTime = try container.decode(String.self, forKey: .endTime)
        hallId = try container.decode(String.self, forKey: .hallId)
    }
}

struct Item {
    let id: Int
    let name: String
    let ingredients: String
    let course: String
    let meat: Bool
    let animalProducts: Bool
    let alcohol: Bool
    let treeNut: Bool
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
}

extension Item: Decodable {
    enum ItemCodingKeys: String, CodingKey {
        case id
        case name
        case ingredients
        case course
        case meat
        case animalProducts = "animal_products"
        case alcohol
        case treeNut = "tree_nut"
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
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        course = try container.decode(String.self, forKey: .course)
        meat = try container.decode(Bool.self, forKey: .meat)
        animalProducts = try container.decode(Bool.self, forKey: .animalProducts)
        alcohol = try container.decode(Bool.self, forKey: .alcohol)
        treeNut = try container.decode(Bool.self, forKey: .treeNut)
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
    }
}

struct Nutrition {
    let servingSize: String?
    let calories: Int

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
        case servingSize = "serving_size"
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

        servingSize = try container.decode(String?.self, forKey: .servingSize)
        calories = try container.decode(Int.self, forKey: .calories)

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
