//
//  FavoritesView.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//
import SwiftUI

struct FavoritesView: View {
    @StateObject private var vm = FavoritesViewModel()

    var body: some View {
        NavigationStack {
            List(vm.favorites) { product in
                NavigationLink(product.title) {
                    ProductDetailView(productId: product.id)
                }
            }
            .navigationTitle("Favoritos")
            .task {
                vm.loadFavorites()
            }
        }
    }
}
