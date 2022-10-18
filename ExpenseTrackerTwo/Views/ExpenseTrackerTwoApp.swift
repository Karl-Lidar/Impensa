//
//  ExpenseTrackerTwoApp.swift
//  ExpenseTrackerTwo
//
//  Created by Karl Lidar on 2022-09-07.
//

import SwiftUI

@main
struct ExpenseTrackerTwoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
