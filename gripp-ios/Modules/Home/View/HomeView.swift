//
//  HomeView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    let postItemImages = [
        PostGridItem(thumbnailPath: "img1.jpg", processing: true, conquered: false),
        PostGridItem(thumbnailPath: "img2.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img3.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img4.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img5.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img6.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img7.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img8.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img9.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context)
                .padding(.leading, 31).padding(.top, 6)
                .foregroundColor(Color(named:"TextSubduedColor"))
            Button(action:{}){
                Text("masterUserId").font(.large_title)
                Image(systemName: "arrow.forward")
            }.padding(.leading, 30).padding(.top, 7)
                .foregroundColor(Color(named: "TextMasterColor"))
            HStack(alignment: .center){
                Text("userInfoString").font(.foot_note)
                    .padding(.leading, 32)
                
                Spacer()
                
                Button(action: {}){
                    Text("난이도").font(.foot_note)
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 32)
                }
                .foregroundColor(Color(named: "TextMasterColor"))
            }.padding(.top, 4).padding(.bottom, 16)
            
            ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: true)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
        }
        .background(Color(named:"BackgroundSubduedColor"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
