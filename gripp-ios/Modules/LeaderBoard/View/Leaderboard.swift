//
//  Leaderboard.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct LeaderBoardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context).padding(.leading, 31).padding(.top, 6).opacity(0.6)
            HStack{
                Text("리더보드").font(.large_title)
            }.padding(.leading, 30).padding(.top, 7).padding(.bottom, 10)
            
            HStack(alignment: .bottom, spacing: 0){
                Spacer()
                VStack(alignment: .center, spacing: 0){
                    Text("아이디").font(.podium_id).padding(.top, 18)
                    Text("V14.1").font(.podium_level).padding(.top, 10)
                    Spacer()
                    Text("2위").font(.podium_footer).frame(width: 110, height: 30)
                }
                .frame(
                    width: 100,
                    height: 105
                )
                .background(Color("#FFFFFF").opacity(0.5))
                VStack{
                    Image(systemName: "crown.fill").foregroundColor(Color("#FFC400")).padding(.bottom, 1)
                    VStack(alignment: .center, spacing: 0){
                        Text("아이디").font(.podium_id).padding(.top, 21)
                        Text("V14.1").font(.podium_level).padding(.top, 10)
                        Spacer()
                        Text("1위").font(.podium_footer).frame(width: 105, height: 30).background(Color("#FFDC67"))
                    }
                    .frame(width: 105, height: 120)
                    .background(Color("#FFFFFF"))
                }
                VStack(alignment: .center, spacing: 0){
                    Text("아이디").font(.podium_id).padding(.top, 15)
                    Text("V14.1").font(.podium_level).padding(.top, 7)
                    Spacer()
                    Text("3위").font(.podium_footer).frame(width: 110, height: 30)
                }
                .frame(
                    width: 100,
                    height: 90
                )
                .background(Color("#FFFFFF").opacity(0.5))
                Spacer()
            }.zIndex(1)
            
            ScoreListView()
                .background(.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color("#BFBFBF"), radius: 20)
        }
        .background(Color("#EFEFEF"))
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
