//
//  Product.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


struct Product: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}
