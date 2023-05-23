//
//  paintApp.swift
//  paint
//
//  Created by userext on 19/05/23.
//

import SwiftUI

@main
struct paintApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
