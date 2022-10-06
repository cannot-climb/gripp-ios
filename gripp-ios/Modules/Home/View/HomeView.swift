//
//  HomeView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context).padding(.leading, 31).padding(.top, 6).opacity(0.6)
            HStack{
                Text("아이디").font(.large_title)
                Image(systemName: "arrow.forward")
            }.padding(.leading, 30).padding(.top, 7)
            HStack{
                Text("상위 30%, V3.78").font(.foot_note).padding(.leading, 32)
                Spacer()
                Image(systemName: "line.3.horizontal.decrease.circle").padding(.trailing, 32)
            }.padding(.top, 5).padding(.bottom, 13)
            
            ImageGrid()
            .background(.white)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .shadow(color: Color("#DADADA"), radius: 20)
        }
        .background(Color("#EFEFEF"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
