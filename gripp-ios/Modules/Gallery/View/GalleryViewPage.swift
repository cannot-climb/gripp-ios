//
//  GalerryViewPage.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/02.
//

import SwiftUI

struct GalleryViewPage: View {
    var title: String
    var pre: String?
    @Binding var content: String
    var post: String?
    var pageIndex: Int
    var pageCount: Int
    
    var body: some View {
        VStack(spacing: 4){
            HStack{
                Text(title).font(.player_id)
                    .padding(.leading, 12)
                    .padding(.vertical, 12)
                Spacer()
                HStack(spacing: 4){
                    ForEach(0..<pageCount){ i in
                        if(i == pageIndex){
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5, height: 5)
                                .opacity(0.6)
                        }
                        else{
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 5, height: 5)
                                .opacity(0.2)
                        }
                    }
                }
                Spacer()
                    .frame(width: 12)
            }
            HStack{
                Spacer()
                Text((pre ?? "") + content + (post ?? ""))
                    .font(.large_title)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }
        }
    }
}

//struct GalleryViewPage_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryViewPage(title: "게시물", content: "12개",pageIndex: 2,pageCount: 3)
//    }
//}
