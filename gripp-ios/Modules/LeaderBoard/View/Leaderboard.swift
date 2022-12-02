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
    
    @State var galleryViewModel0 = GalleryViewModel()
    @State var galleryViewModel1 = GalleryViewModel()
    @State var galleryViewModel2 = GalleryViewModel()
    
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
                    if(leaderboardViewModel.podiums.count >= 2){
                        NavigationLink(destination: GalleryView(contextString: "리더보드", shouldHaveChin: shouldHaveChin).environmentObject(galleryViewModel1).navigationBarBackButtonHidden(true)){
                            VStack(alignment: .center, spacing: 0){
                                Spacer()
                                Text(leaderboardViewModel.podiums[1].username).font(.podium_id)
                                    .padding(.vertical, 8)
                                Text(leaderboardViewModel.podiums[1].level).font(.player_tier_pill)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(leaderboardViewModel.tierColors[1].colors[2])
                                    .background(getGradient(color1: leaderboardViewModel.tierColors[1].colors[0], color2: leaderboardViewModel.tierColors[1].colors[1]))
                                    .cornerRadius(50, corners: .allCorners)
                                Spacer()
                                HStack{
                                    Text(leaderboardViewModel.podiums[1].rank).font(.podium_footer)
                                }.frame(width: 110, height: 30)
//                                    .background(Color("#d0d0d0"))
                            }
                            .foregroundColor(Color(named: "TextMasterColor"))
                            .frame(width: 100, height: 115)
                            .background(Color(named:"BackgroundMasterColor").opacity(0.5))
                        }
                    }
                    
                    if(leaderboardViewModel.podiums.count >= 1){
                        NavigationLink(destination: GalleryView(contextString: "리더보드", shouldHaveChin: shouldHaveChin).environmentObject(galleryViewModel0).navigationBarBackButtonHidden(true)){
                            VStack{
                                Image(systemName: "crown.fill").foregroundColor(Color("#FFC400")).padding(.bottom, 1)
                                VStack(alignment: .center, spacing: 0){
                                    Spacer()
                                    Text(leaderboardViewModel.podiums[0].username).font(.podium_id)
                                        .padding(.bottom, 10)
                                    Text(leaderboardViewModel.podiums[0].level).font(.player_tier_pill)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(leaderboardViewModel.tierColors[0].colors[2])
                                        .background(getGradient(color1: leaderboardViewModel.tierColors[0].colors[0], color2: leaderboardViewModel.tierColors[0].colors[1]))
                                        .cornerRadius(50, corners: .allCorners)
                                    Spacer()
                                    HStack{
                                        Text(leaderboardViewModel.podiums[0].rank).font(.podium_footer)
                                    }.frame(width: 105, height: 30)
                                        .foregroundColor(.black)
                                        .background(Color("#FFDC67"))
                                }
                                .foregroundColor(Color(named: "TextMasterColor"))
                                .frame(width: 105, height: 140)
                                .background(Color(named:"BackgroundMasterColor"))
                            }
                        }
                    }
                    
                    if(leaderboardViewModel.podiums.count >= 3){
                        NavigationLink(destination: GalleryView(contextString: "리더보드", shouldHaveChin: shouldHaveChin).environmentObject(galleryViewModel2).navigationBarBackButtonHidden(true)){
                                VStack(alignment: .center, spacing: 0){
                                    Spacer()
                                    Text(leaderboardViewModel.podiums[2].username).font(.podium_id).padding(.vertical, 5)
                                    Text(leaderboardViewModel.podiums[2].level).font(.player_tier_pill)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(leaderboardViewModel.tierColors[2].colors[2])
                                        .background(getGradient(color1: leaderboardViewModel.tierColors[2].colors[0], color2: leaderboardViewModel.tierColors[2].colors[1]))
                                        .cornerRadius(50, corners: .allCorners)
                                    Spacer()
                                    HStack{
                                        Text(leaderboardViewModel.podiums[2].rank).font(.podium_footer)
                                    }.frame(width: 105, height: 30)
//                                        .background(Color("#674019"))
                                }
                                .foregroundColor(Color(named: "TextMasterColor"))
                                .frame(width: 100, height: 100)
                                .background(Color(named:"BackgroundMasterColor").opacity(0.5))
                            }
                    }
                    Spacer()
                }.zIndex(1)
                
                ZStack{
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    ScoreListView(shouldHaveChin: shouldHaveChin, users: $leaderboardViewModel.defaultBoard)
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
            })
            .onChange(of: leaderboardViewModel.topBoard, perform: { podium in
                galleryViewModel0.username = leaderboardViewModel.podiums[0].username
                galleryViewModel1.username = leaderboardViewModel.podiums[1].username
                galleryViewModel2.username = leaderboardViewModel.podiums[2].username
            })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView(shouldHaveChin: false).environmentObject(LeaderboardViewModel())
    }
}
