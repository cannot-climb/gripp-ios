//
//  ContentView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/09/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
