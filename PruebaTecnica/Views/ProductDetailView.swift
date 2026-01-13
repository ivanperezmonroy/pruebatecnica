//
//  ProductDetailView.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var vm: ProductDetailViewModel

    init(productId: Int) {
        _vm = StateObject(
            wrappedValue: ProductDetailViewModel(productId: productId)
        )
    }

    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView("Cargando...")
            } else if let product = vm.product {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        AsyncImage(url: URL(string: product.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 250)

                        HStack {
                            Text(product.title)
                                .font(.title2)
                                .bold()

                            Spacer()

                            Button {
                                vm.toggleFavorite()
                            } label: {
                                Image(systemName: vm.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                        }

                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.title3)

                        Text(product.description)
                            .font(.body)
                    }
                    .padding()
                }
            } else {
                Text("Producto no disponible")
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.load()
        }
    }
}
