//
//  AppCoordinator.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import SwiftUI

struct AppCoordinator: View {
    var body: some View {
        TabView {
            CategoriesView()
                .tabItem {
                    Label("Productos", systemImage: "list.bullet")
                }

            FavoritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "heart.fill")
                }
        }
    }
}
