//
//  CategoriesView.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import SwiftUI

struct CategoriesView: View {
    @StateObject private var vm = CategoriesViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Cargando categorías...")
                } else if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    List(vm.categories) { category in
                        NavigationLink {
                            ProductsView(category: category.name)
                        } label: {
                            Text(category.name.capitalized)
                        }
                    }
                }
            }
            .navigationTitle("Categorías")
        }
        .task {
            await vm.loadCategories()
        }
    }
}
