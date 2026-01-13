//
//  CDProductModel.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//

import CoreData

extension CDProduct {

    func toProduct() -> Product {
        Product(
            id: Int(id),
            title: title ?? "",
            price: price,
            description: desc ?? "",
            category: category ?? "",
            image: image ?? ""
        )
    }

    func update(from product: Product) {
        id = Int64(product.id)
        title = product.title
        price = product.price
        desc = product.description
        category = product.category
        image = product.image
    }
}

