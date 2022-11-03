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
    
    var body: some View {
        ScrollView{
            ForEach((0...40), id: \.self){ item in
                NavigationLink(destination: GalleryView(contextString: "리더보드", shouldHaveChin: shouldHaveChin).navigationBarBackButtonHidden(true)) {
                    HStack(alignment: .center, spacing: 15){
                        Text("아이디").font(.head_line).foregroundColor(Color(named:"TextMasterColor"))
                        Spacer()
                        Text("상위 30%, V3.78").font(.subheadline).foregroundColor(Color(named:"TextMasterColor"))
                        Image("ArrowRight").foregroundColor(Color(named:"TextMasterColor"))
                    }.padding(.leading, 23).padding(.trailing, 31).padding(.top, 16).padding(.bottom, 16)
                }
            }
            if(shouldHaveChin){
                Spacer().frame(height: DOCK_HEIGHT)
            }
        }.background(Color(named:"BackgroundMasterColor"))
            .scrollIndicators(.hidden)
    }
}
