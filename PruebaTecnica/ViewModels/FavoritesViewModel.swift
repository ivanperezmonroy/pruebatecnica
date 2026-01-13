//
//  FavoritesViewModel.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Product] = []

    private let repository: ProductRepository

    init(repository: ProductRepository = ProductRepository()) {
        self.repository = repository
    }

    func loadFavorites() {
        favorites = repository.getFavorites()
    }
}
