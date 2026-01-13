//
//  ProductsViewModel.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import Foundation
import Combine

@MainActor
final class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: ProductRepository

    init(repository: ProductRepository = ProductRepository()) {
        self.repository = repository
    }

    func fetchProducts(category: String) async {
        isLoading = true
        do {
            products = try await repository.getProducts(category: category)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
