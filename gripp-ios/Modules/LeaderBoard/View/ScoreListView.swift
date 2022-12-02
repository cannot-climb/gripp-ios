//
//  ScoreListView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct ScoreListView: View {
    public var shouldHaveChin: Bool
    @Binding var users: [User]
    
    
    var body: some View {
        ScrollView{
            ForEach(users, id: \.self){ item in
                let galleryViewModel = GalleryViewModel()
                let pallette = tierColorProvider(item.tier!)
                NavigationLink(destination: GalleryView(contextString: "리더보드", shouldHaveChin: shouldHaveChin).environmentObject(galleryViewModel).navigationBarBackButtonHidden(true)) {
                    HStack(alignment: .center, spacing: 15){
                        Text("V\(item.tier!)").font(.player_tier_pill)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .foregroundColor(pallette[2])
                            .background(getGradient(color1: pallette[0], color2: pallette[1]))
                            .cornerRadius(50, corners: .allCorners)
                        Text("\(item.username!)").font(.head_line).foregroundColor(Color(named:"TextMasterColor"))
                        Spacer()
                        Text("\(item.rank!)위, 상위 \(String(100 - (item.percentile ?? -1)))%").font(.sub_head_line).foregroundColor(Color(named:"TextMasterColor"))
                        Image("ArrowRight").foregroundColor(Color(named:"TextMasterColor"))
                    }.padding(.leading, 23).padding(.trailing, 31).padding(.top, 16).padding(.bottom, 16)
                }
                .onAppear(perform:{
                    galleryViewModel.username = item.username!
//                    galleryViewModel.loadUserInfo()
                })
            }
            if(shouldHaveChin){
                Spacer().frame(height: DOCK_HEIGHT)
            }
        }.padding(.vertical, 16)
        .background(Color(named:"BackgroundMasterColor"))
        .scrollIndicators(.hidden)
    }
}


struct ScoreListView_Preview: PreviewProvider {
    static var previews: some View {
        ScoreListView(shouldHaveChin: false, users: .constant([User(username: "Test", tier: 20, score: 25, rank: 190, percentile: 55, articleCount: 20, articleCertifiedCount: 1, registerDateTime: "2022-02-02 20:20:20")]))
    }
}
