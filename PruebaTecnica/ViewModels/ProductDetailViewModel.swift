//
//  ProductDetailViewModel.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//

import Combine

@MainActor
final class ProductDetailViewModel: ObservableObject {
    @Published var product: Product?
    @Published var isFavorite = false
    @Published var isLoading = false

    private let repository: ProductRepository
    private let productId: Int

    init(
        productId: Int,
        repository: ProductRepository = ProductRepository()
    ) {
        self.productId = productId
        self.repository = repository
    }

    func load() async {
        isLoading = true

        do {
            product = try await repository.getProduct(id: productId)
            isFavorite = repository.isFavorite(productId: productId)
        } catch {
            print(error)
        }

        isLoading = false
    }

    func toggleFavorite() {
        repository.toggleFavorite(productId: productId)
        isFavorite.toggle()
    }
}
