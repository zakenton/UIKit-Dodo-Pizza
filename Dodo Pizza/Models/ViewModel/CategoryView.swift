import Foundation

enum CategoryMappingError: Error {
    case invalidCategory(name: String)
}

enum CategoryView: String, Codable {
    case pizza = "Pizza"
    case set = "Combo"
    case drink = "Drink"
    case coffee = "Coffee"
    case dessert = "Dessert"
    case snack = "Snack"
    case sauce = "Sauce"
    case other = "Other"
    
    init?(from string: String) {
        switch string.lowercased() {
        case "pizza": self = .pizza
        case "combo": self = .set
        case "drink": self = .drink
        case "coffee": self = .coffee
        case "dessert": self = .dessert
        case "snack": self = .snack
        case "sauce": self = .sauce
        default: return nil
        }
    }
}
