//
//  gripp_iosApp.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/09/20.
//

import SwiftUI

@main
struct gripp_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
