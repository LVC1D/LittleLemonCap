//
//  LittleLemonCapApp.swift
//  LittleLemonCap
//
//  Created by Illia Berezovskyi on 14/10/2023.
//

import SwiftUI

@main
struct LittleLemonCapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
