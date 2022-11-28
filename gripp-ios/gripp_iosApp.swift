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
    
    @StateObject var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .background(Color(named: "BackgroundSubduedColor"))
        }
    }
}
