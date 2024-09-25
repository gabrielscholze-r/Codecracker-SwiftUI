//
//  DataController.swift
//  codecracker
//
//  Created by user264588 on 9/24/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name:"Model")
    init(){
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }}
    }
}
