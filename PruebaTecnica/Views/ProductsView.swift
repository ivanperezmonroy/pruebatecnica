//
//  ProductsView.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var vm = ProductsViewModel()
    let category: String

    var body: some View {
        List(vm.products) { product in
            NavigationLink(product.title) {
                ProductDetailView(productId: product.id)
            }
        }
        .navigationTitle(category)
        .task {
            await vm.fetchProducts(category: category)
        }
    }
}
