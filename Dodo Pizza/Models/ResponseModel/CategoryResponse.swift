struct CategoryResponse: Decodable {
    let id: Int
    let name: String
}

extension CategoryResponse {
    func toCategoryMenu() -> CategoryView? {
        guard let category = CategoryView(from: name) else {
            print("Error map category - id: \(id), name: \(name)")
            return nil
        }
        return category
    }
}
