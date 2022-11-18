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
                NavigationLink(destination: GalleryView(contextString: "리더보드", shouldHaveChin: shouldHaveChin).environmentObject(galleryViewModel).navigationBarBackButtonHidden(true)) {
                    HStack(alignment: .center, spacing: 15){
                        Text(item.username!).font(.head_line).foregroundColor(Color(named:"TextMasterColor"))
                        Spacer()
                        Text("V\(String(item.tier ?? -1)), 상위 \(String(100 - (item.percentile ?? -1)))%").font(.subheadline).foregroundColor(Color(named:"TextMasterColor"))
                        Image("ArrowRight").foregroundColor(Color(named:"TextMasterColor"))
                    }.padding(.leading, 23).padding(.trailing, 31).padding(.top, 16).padding(.bottom, 16)
                }
                .onAppear(perform:{
                    galleryViewModel.username = item.username!
                    galleryViewModel.loadUserInfo()
                })
            }
            if(shouldHaveChin){
                Spacer().frame(height: DOCK_HEIGHT)
            }
        }
        .background(Color(named:"BackgroundMasterColor"))
        .scrollIndicators(.hidden)
    }
}
