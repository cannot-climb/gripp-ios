//
//  Leaderboard.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct LeaderBoardView: View {
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel
    
    @State var isNavigationBarHidden: Bool = true
    let shouldHaveChin: Bool
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0){
                Text("Gripp").font(.context).padding(.leading, 31).padding(.top, 6).foregroundColor(Color(named:"TextSubduedColor"))
                HStack{
                    Text("리더보드").font(.large_title)
                }.padding(.leading, 30).padding(.top, 5).padding(.bottom, 10)
                
                HStack(alignment: .bottom, spacing: 0){
                    Spacer()
                    VStack(alignment: .center, spacing: 0){
                        Text(leaderboardViewModel.podiums[1].username).font(.podium_id).padding(.top, 18)
                        Text(leaderboardViewModel.podiums[1].level).font(.podium_level).padding(.top, 10)
                        Spacer()
                        Text(leaderboardViewModel.podiums[1].rank).font(.podium_footer).frame(width: 110, height: 30)
                    }
                    .frame(width: 100, height: 105)
                    .background(Color(named:"BackgroundMasterColor").opacity(0.5))
                    VStack{
                        Image(systemName: "crown.fill").foregroundColor(Color("#FFC400")).padding(.bottom, 1)
                        VStack(alignment: .center, spacing: 0){
                            Text(leaderboardViewModel.podiums[0].username).font(.podium_id).padding(.top, 21)
                            Text(leaderboardViewModel.podiums[0].level).font(.podium_level).padding(.top, 10)
                            Spacer()
                            Text(leaderboardViewModel.podiums[0].rank).font(.podium_footer).frame(width: 105, height: 30).background(Color("#FFDC67")).foregroundColor(Color("#000000"))
                        }
                        .frame(width: 105, height: 120)
                        .background(Color(named:"BackgroundMasterColor"))
                    }
                    VStack(alignment: .center, spacing: 0){
                        Text(leaderboardViewModel.podiums[2].username).font(.podium_id).padding(.top, 15)
                        Text(leaderboardViewModel.podiums[2].level).font(.podium_level).padding(.top, 7)
                        Spacer()
                        Text(leaderboardViewModel.podiums[2].rank).font(.podium_footer).frame(width: 110, height: 30)
                    }
                    .frame(width: 100, height: 90)
                    .background(Color(named:"BackgroundMasterColor").opacity(0.5))
                    Spacer()
                }.zIndex(1)
                
                ZStack{
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    ScoreListView(shouldHaveChin: shouldHaveChin, users: $leaderboardViewModel.combinedBoard)
                        .environmentObject(leaderboardViewModel)
                }
                .background(Color(named: "BackgroundMasterColor"))
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
            }
            .background(Color(named:"BackgroundSubduedColor"))
            .navigationBarHidden(true)
            .onAppear(perform: {
                leaderboardViewModel.loadLeaderboard()
                print(leaderboardViewModel.topBoard)
            })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView(shouldHaveChin: false)
    }
}
