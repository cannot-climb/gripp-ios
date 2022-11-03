//
//  Tabbar.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/03.
//

import Foundation
import SwiftUI

struct TabBar: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    var homeView = HomeView()
    var leaderBoard = LeaderBoardView()
    var myProfileView = MyGalleryView()
    
    
    @State private var isPresented = false
    
    var body: some View {
        TabView{
            
            homeView.tabItem {
                Image("Home")
                Text("홈")
            }
            
            leaderBoard.tabItem {
                Image("Leaderboard")
                Text("리더보드")
            }
            
            myProfileView.tabItem {
                Image("Person")
                Text("내 프로필")
            }
            Button("Present") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                UploadView()
            }
            .tabItem {
                Image("Video")
                Text("영상 올리기")
            }
        }
    }
    
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
