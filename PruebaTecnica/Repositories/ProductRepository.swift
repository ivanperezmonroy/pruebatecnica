//
//  ProductRepository.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import CoreData

final class ProductRepository {

    private let service: APIServiceProtocol
    private let context: NSManagedObjectContext
    private let network = NetworkMonitor.shared

    init(
        service: APIServiceProtocol = APIService(),
        context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    ) {
        self.service = service
        self.context = context
    }

    func getProducts(category: String) async throws -> [Product] {
        if network.isConnected {
            let products = try await service.fetchProducts(category: category)
            save(products: products)
            print("Guardando Productos ", products.count)
            return products
        } else {
            print("Consultando Productos desde CoreData")
            return fetchFromCoreData(category: category)
        }
    }
    
    func getProduct(id: Int) async throws -> Product {
        if network.isConnected {
            let product = try await service.fetchProduct(id: id)
            save(products: [product])
            return product
        } else {
            return try fetchProductFromCoreData(id: id)
        }
    }

    private func fetchProductFromCoreData(id: Int) throws -> Product {
        let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        guard let cdProduct = try context.fetch(request).first else {
            throw NSError(
                domain: "ProductRepository",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Product not found in CoreData"]
            )
        }

        return cdProduct.toProduct()
    }

    private func save(products: [Product]) {
        products.forEach { product in
            let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", product.id)

            let cdProduct = (try? context.fetch(request).first) ?? CDProduct(context: context)
            cdProduct.update(from: product)
        }

        try? context.save()
    }

    private func fetchFromCoreData(category: String) -> [Product] {
        let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", category)
        
        let result = (try? context.fetch(request)) ?? []
        return result.map { $0.toProduct() }
    }
    
    func getFavorites() -> [Product] {
        let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == true")

        return (try? context.fetch(request))?.map { $0.toProduct() } ?? []
    }
    
    func toggleFavorite(productId: Int) {
        let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", productId)

        if let product = try? context.fetch(request).first {
            product.isFavorite.toggle()
            try? context.save()
        }
    }

    func isFavorite(productId: Int) -> Bool {
        let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d AND isFavorite == true", productId)
        return (try? context.count(for: request)) ?? 0 > 0
    }

}

