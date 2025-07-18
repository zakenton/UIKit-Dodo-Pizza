//
//  ProductCartViewModel.swift
//  Dodo Pizza
//
//  Created by Zakhar on 16.07.25.
//

import Foundation

struct ProductCartViewModel {
    let name: String
    let cartId: Int
    let imageURL: String
    let size: String
    let dough: String
    let additive: String
    let price: String
    let quantity: Int
}

final class MockProductCartViewModel {
    static var products = [
        ProductCartViewModel(
            name: "Hawaii",
            cartId: 01,
            imageURL: "hawaii",
            size: "30 cm",
            dough: "Traditional",
            additive: "ham, pineapple, mozzarella",
            price: "10.55 €",
            quantity: 2
        ),
        ProductCartViewModel(
            name: "Pepperoni",
            cartId: 02,
            imageURL: "pepperoni",
            size: "35 cm",
            dough: "Traditional",
            additive: "pepperoni, extra cheese, basil",
            price: "12.99 €",
            quantity: 1
        ),
        ProductCartViewModel(
            name: "Margherita",
            cartId: 03,
            imageURL: "margarita",
            size: "30 cm",
            dough: "Fine",
            additive: "tomato sauce, mozzarella, fresh basil",
            price: "9.99 €",
            quantity: 3
        ),
        ProductCartViewModel(
            name: "BBQ Chicken",
            cartId: 04,
            imageURL: "chill-grill",
            size: "35 cm",
            dough: "Traditional",
            additive: "grilled chicken, red onions, BBQ sauce",
            price: "13.50 €",
            quantity: 1
        ),
        ProductCartViewModel(
            name: "Beef Stroganov",
            cartId: 05,
            imageURL: "beef-stroganov",
            size: "30 cm",
            dough: "Fine",
            additive: "bell peppers, mushrooms, olives, red onions",
            price: "11.25 €",
            quantity: 2
        ),
        ProductCartViewModel(
            name: "Four Cheese",
            cartId: 06,
            imageURL: "four-cheese",
            size: "35 cm",
            dough: "Traditional",
            additive: "mozzarella, gorgonzola, parmesan, ricotta",
            price: "14.75 €",
            quantity: 1
        )
    ]
}
