import Foundation

struct ProductResponse: Codable {
    let id: UInt
    let category: String
    let name: String
    let price: String
    let description: String
    let imageURL: String
    let availableDough: [String: String]?
    let availableSize: [String: String]?
    let availableAdditives: [ProductAdditiveResponse]?
}

struct ProductAdditiveResponse: Equatable, Codable {
    let name: String
    let price: String
    let imageURL: String
}


extension ProductResponse {
    func toProductView() -> ProductView? {
        guard let savePrice = mapPrice(form: price) else {return nil}
        
        let saveCategory = mapCategory(from: category)
        var saveDough: [ProductOption]? = nil
        var saveProductSize: [ProductOption]? = nil
        var saveAddedOptions: [ProductAdditiveView]? = nil
        
        
        switch saveCategory {
        case .pizza:
            saveDough = mapDough(from: availableDough)
            saveProductSize = mapSize(form: availableSize)
            saveAddedOptions = mapAdditives(from: availableAdditives)
        case .coffee:
            saveProductSize = mapSize(form: availableSize)
        default:
            saveProductSize = mapSize(form: availableSize)
        }

        return ProductView(id: id,
                           name: name,
                           category: saveCategory,
                           description: description,
                           price: savePrice,
                           imageURL: imageURL,
                           dough: saveDough,
                           size: saveProductSize,
                           additive: saveAddedOptions)
    }
}

private extension ProductResponse {
    
    func mapCategory(from str: String) -> CategoryView {
        guard let category = CategoryView(from: str) else {
            let error = MappingError.invalidCategory(str)
            print(error.errorDescription)
            return .other
        }
        return category
    }
    
    func mapPrice(form str: String) -> Double? {
        guard let price = Double(str) else {
            let error = MappingError.invalidPrice(str)
            print(error.errorDescription)
            return nil
        }
        return price
    }
    
    func mapDough(from doughDict: [String: String]?) -> [ProductOption]? {
        guard let doughDict = doughDict else { return nil }
        
        let mapped = doughDict.compactMap { option, priceStr -> ProductOption? in
            guard let price = Double(priceStr) else {
                let error = MappingError.invalidDoughPrice(option)
                print(error.errorDescription)
                return nil
            }
            
            let isSelected = (option == DoughType.traditional.rawValue)
            return ProductOption(option: option, isSelected: isSelected, price: price)
        }
        
        return mapped.sorted {$0.price < $1.price}
    }
    
    func mapSize(form sizeDict: [String: String]?) -> [ProductOption]? {
        guard let sizeDict = sizeDict else { return nil }
        
        let mapped = sizeDict.compactMap { option, priceStr -> ProductOption? in
            guard let price = Double(priceStr) else {
                let error = MappingError.invalidSizePrice(option)
                print(error.errorDescription)
                return nil
            }
            
            let isSelected = (option == SizeType.standart.rawValue)
            return ProductOption(option: option, isSelected: isSelected, price: price)
        }
        
        return mapped.sorted { $0.price < $1.price}
    }
    
    func mapAdditives(from additives: [ProductAdditiveResponse]?) -> [ProductAdditiveView]? {
        guard let additives = additives else { return nil }

        let mapped = additives.compactMap { additive -> ProductAdditiveView? in
            guard let price = Double(additive.price) else {
                let error = MappingError.invalidAdditives(additive.name)
                print(error.errorDescription)
                return nil
            }

            return ProductAdditiveView(
                name: additive.name,
                price: price,
                imageURL: additive.imageURL,
                isSelected: false
            )
        }

        return mapped.isEmpty ? nil : mapped
    }
}
