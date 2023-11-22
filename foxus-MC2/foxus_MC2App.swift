//
//  foxus_MC2App.swift
//  foxus-MC2
//
//  Created by leena alyami on 08/05/1445 AH.
//

import SwiftUI

@main
struct foxus_MC2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
