//
//  Tabbar.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/03.
//

import Foundation
import SwiftUI

struct TabBar: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var homeView = HomeView()
    var leaderBoard = LeaderBoardView()
//    var uploadView = UploadView(imagePath: "img3.jpg")
    var uploadView = PlayerView()
    var myProfileView = GalleryView()
    

    @State private var isPresented = false
    
    var body: some View {
        TabView{
            homeView
            .tabItem {
                    Image(systemName: "mosaic.fill")
                    Text("홈")
            }
            leaderBoard
                .tabItem {
                    Image(systemName: "list.number")
                    Text("리더보드")
            }
            myProfileView
                .tabItem {
                    Image(systemName: "video.fill")
                    Text("내 프로필")
            }
            Button("Present") {
                isPresented.toggle()
            }
//            .sheet(isPresented: $isPresented) {
//                uploadView
////                    .ignoresSafeArea(.all)
//            }
            .fullScreenCover(isPresented: $isPresented, content: {
                uploadView
//                    .ignoresSafeArea(.all)
            })
            .tabItem {
                Image(systemName: "mappin.circle.fill")
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

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
