//
//  GalleryView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/05.
//

import SwiftUI

struct MyGalleryView: View {
    
    let postItemImages = [
        PostGridItem(thumbnailPath: "img1.jpg", processing: true, conquered: false),
        PostGridItem(thumbnailPath: "img2.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img3.jpg", processing: true, conquered: false),
        PostGridItem(thumbnailPath: "img4.jpg", processing: true, conquered: false),
        PostGridItem(thumbnailPath: "img5.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img6.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img7.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img8.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img9.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img10.jpg", processing: true, conquered: true),
        PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img12.jpg", processing: true, conquered: false),
        PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context).padding(.leading, 31).padding(.top, 6).foregroundColor(Color(named:"TextSubduedColor"))
            HStack{
                Text("내 정보").font(.large_title)
                Spacer()
                Button(action:{}){
                    Text("로그아웃").font(.foot_note)
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 32)
                }.foregroundColor(Color(named: "TextMasterColor"))
            }.padding(.leading, 30).padding(.top, 7).padding(.bottom, 30)
            
            VStack(alignment: .center){
                HStack{
                    Spacer()
                    Text("전체 순위 : 42위")
                    Spacer()
                    Text("티어 : 12")
                    Spacer()
                }.padding(.bottom, 5)
                HStack{
                    Spacer()
                    Text("게시물 수 : 138")
                    Spacer()
                    Text("성공 횟수 : 63")
                    Spacer()
                }.padding(.bottom, 5)
                HStack{
                    Spacer()
                    Text("상위 99%")
                    Spacer()
                    Text("점수 : 12.5")
                    Spacer()
                }.padding(.bottom, 5)
                HStack{
                    Spacer()
                    Text("Gripp과 함께 n일째")
                    Spacer()
                }
            }.padding(.bottom, 30)
            
            ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: false)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
            
        }
        .background(Color(named:"BackgroundSubduedColor"))
        
    }
}


struct MyGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        MyGalleryView()
    }
}
