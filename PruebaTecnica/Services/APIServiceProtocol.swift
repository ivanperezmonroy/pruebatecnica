//
//  APIServiceProtocol.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


protocol APIServiceProtocol {
    func fetchCategories() async throws -> [String]
    func fetchProducts(category: String) async throws -> [Product]
    func fetchProduct(id: Int) async throws -> Product
}
