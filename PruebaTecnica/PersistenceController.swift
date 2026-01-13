//
//  PersistenceController.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PruebaTecnica")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData error \(error)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
