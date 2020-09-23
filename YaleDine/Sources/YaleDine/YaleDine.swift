struct YaleDine {
    static let API_ROOT = "https://yaledine.com/api/"
        
    static func get(endpoint: String, then: @escaping (Bool) -> Void) {
        let url = URL(string: self.API_ROOT + endpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                then(false)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let json = json as? [String: Any] {
                then(true)
                print(json)
            }
        }
        task.resume()
    }
    
    static func getLocations(then: @escaping (Bool) -> Void) {
        return self.get("locations": <#T##String#>, then: <#T##(Bool) -> Void#>)
    }
    
//    /locations
//    /locations/:id
//    /locations/:id
//    /locations/:id/managers
//    /locations/:id/meals
//    /meals/:id
//    /meals/:id/items
//    /meals/:id/items
//    /meals/:id/courses
//    /courses/:id
//    /courses/:id/items
//    /items/:id
//    /items/:id/nutrition
}
