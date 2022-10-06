//
//  GalleryView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/05.
//

import SwiftUI

struct GalleryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context).padding(.leading, 31).padding(.top, 6).opacity(0.6)
            HStack{
                Text("아이디").font(.large_title)
            }.padding(.leading, 30).padding(.top, 7)
            HStack{
            }.padding(.top, 5).padding(.bottom, 13)
            
            ImageGrid()
            .background(.white)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .shadow(color: Color("#DADADA"), radius: 20)
            
        }
        .background(Color("#EFEFEF"))
        
    }
}


