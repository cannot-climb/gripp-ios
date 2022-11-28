//
//  ContentView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/09/20.
//

import SwiftUI
import CoreData
import RangeSeekSlider

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isLoginPresented = false
    @State private var isUploadPresented = false
    
    @StateObject var galleryViewModel = GalleryViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var leaderboardViewModel = LeaderboardViewModel()
    
    
    var body: some View {
        ZStack{
            switch viewRouter.currentPage {
            case .home:
                HomeView(shouldHaveChin: true, viewRouter: viewRouter).environmentObject(homeViewModel)
                    .transition(.offset(CGSize(width: 0, height: 20)).combined(with: .opacity))
            case .leader:
                LeaderBoardView(shouldHaveChin: true).environmentObject(leaderboardViewModel)
                    .transition(.offset(CGSize(width: 0, height: 20)).combined(with: .opacity))
            case .myGallery:
                MyGalleryView(shouldHaveChin: true).environmentObject(galleryViewModel)
                    .transition(.offset(CGSize(width: 0, height: 20)).combined(with: .opacity))
            }
            VStack{
                Spacer()
                HStack(spacing: UIScreen.main.bounds.width/18){
                    TabBarItem(title: "홈", iconString: "Home", viewRouter: viewRouter, assignedPage: .home)
                    TabBarItem(title: "리더보드", iconString: "Leaderboard", viewRouter: viewRouter, assignedPage: .leader)
                    TabBarItem(title: "내 정보", iconString: "Person", viewRouter: viewRouter, assignedPage: .myGallery)
                    Image(systemName: "square.fill").resizable().frame(width: 1, height: 30)
                    VStack(alignment: .center){
                        Image("Video").padding(.top, 6)
                        Spacer().frame(height: 5)
                        Text("영상 올리기")
                            .font(.tabbar_item)
                    }
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        isUploadPresented.toggle()
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: DOCK_HEIGHT)
                .background(.regularMaterial)
            }
        }
        .sheet(isPresented: $isUploadPresented){
            UploadView().environmentObject(galleryViewModel)
        }
        .fullScreenCover(isPresented: $isLoginPresented, onDismiss: {
            homeViewModel.loadTitleInfo()
            homeViewModel.loadVideoList()
        }){
            LoginView().environmentObject(LoginViewModel())
                .interactiveDismissDisabled(true)
        }
        .onAppear() {
            if(UserDefaultsManager.shared.getTokens().username == nil){
                isLoginPresented.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
