//
//  meshApp.swift
//  mesh
//
//  Created by Derek Dang on 8/7/22.
//

import SwiftUI

@main
struct meshApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
