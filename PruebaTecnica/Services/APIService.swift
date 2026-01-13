//
//  APIService.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import Foundation

final class APIService: APIServiceProtocol {
    private let baseURL = "https://fakestoreapi.com"

    func fetchCategories() async throws -> [String] {
        let url = URL(string: "\(baseURL)/products/categories")!
        return try await fetch(url)
    }

    func fetchProducts(category: String) async throws -> [Product] {
        let url = URL(string: "\(baseURL)/products/category/\(category)")!
        return try await fetch(url)
    }

    func fetchProduct(id: Int) async throws -> Product {
        let url = URL(string: "\(baseURL)/products/\(id)")!
        return try await fetch(url)
    }

    private func fetch<T: Decodable>(_ url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
