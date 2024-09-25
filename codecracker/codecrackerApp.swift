//
//  codecrackerApp.swift
//  codecracker
//
//  Created by Gabriel Scholze on 8/31/24.
//

import SwiftUI
import CoreData

@main
struct codecrackerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
