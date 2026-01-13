//
//  CategoriesViewModel.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import Foundation
import Combine

@MainActor
final class CategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func loadCategories() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await service.fetchCategories()
            categories = result.map { Category(name: $0) }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
