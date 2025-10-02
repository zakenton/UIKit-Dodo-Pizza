import Foundation

final class ProductMapper {
    func mapProductView(from response: ProductResponse) -> ProductView? {
        guard let price = mapPrice(form: response.price) else { return nil }
        
        let category = mapCategory(from: response.category)
        
        let dough = category == .pizza ? mapDough(from: response.availableDough) : nil
        let size = mapSize(form: response.availableSize)
        let additives = category == .pizza ? mapAdditives(from: response.availableAdditives) : nil
        
        return ProductView(
            id: response.id,
            name: response.name,
            category: category,
            description: response.description,
            price: price,
            imageURL: response.imageURL,
            dough: dough,
            size: size,
            additive: additives
        )
    }
}

private extension ProductMapper {
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
