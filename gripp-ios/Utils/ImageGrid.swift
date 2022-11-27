//
//  ImageGrid.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI
import AVKit

struct ImageGrid: View {
    @StateObject var playerViewModel = PlayerViewModel()
    
    public var postItemImages: [ArticleResponse]
    public var firstItemGiantDecoration = false
    
    @State public var videoUrl = ""
    @Binding public var noMoreData: Bool
    public var shouldHaveChin: Bool
    
    public var refreshAction: ()->()
    public var moreAction: ()->()
    
    @State private var isPresented = false
    private let gridItemLayout = [GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3)]
    
    var body: some View {
        GeometryReader{ gr in
            ScrollView{
                if(postItemImages.count > 3){
                    if(firstItemGiantDecoration){
                        HStack(spacing: 3){
                            ImageCell(articleResponse: postItemImages[0], present: $isPresented, useDecoration: true)
                                .environmentObject(playerViewModel)
                                .frame(width: (gr.size.width-3)*2/3+1)
                            LazyVStack(spacing: 3){
                                ImageCell(articleResponse: postItemImages[1], present: $isPresented)
                                    .environmentObject(playerViewModel)
                                ImageCell(articleResponse: postItemImages[2], present: $isPresented)
                                    .environmentObject(playerViewModel)
                            }
                            .frame(width: (gr.size.width-3)/3-1)
                        }
                        .padding(.bottom, -5)
                    }
                    else{
                        HStack(spacing: 3){
                            ForEach(postItemImages[0..<3]) { item in
                                ImageCell(articleResponse: item, present: $isPresented)
                                    .environmentObject(playerViewModel)
                            }
                        }
                        .padding(.bottom, -5)
                    }
                    LazyVGrid(columns: gridItemLayout, spacing: 3){
                        ForEach(postItemImages[3..<postItemImages.count], id: \.self){ item in
                            ImageCell(articleResponse: item, present: $isPresented)
                                .environmentObject(playerViewModel)
                                .clipped()
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                else if(postItemImages.count > 0){
                    LazyVGrid(columns: gridItemLayout, spacing: 3){
                        ForEach(postItemImages[0..<postItemImages.count], id: \.self){ item in
                            ImageCell(articleResponse: item, present: $isPresented)
                                .environmentObject(playerViewModel)
                                .clipped()
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                else{
                    Text("\n\n게시물이 없어요!")
                        .frame(width: gr.size.width)
                }
                if(postItemImages.count > 0 && !noMoreData){
                    ProgressView()
                        .scaleEffect(1.3)
                        .frame(height: 50)
                        .onAppear(perform: {
                            moreAction()
                        })
                        .onTapGesture {
                            moreAction()
                        }
                }
                if(shouldHaveChin){
                    Spacer().frame(height: DOCK_HEIGHT)
                }
            }
            .background(Color(named:"BackgroundMasterColor"))
            .fullScreenCover(isPresented: $isPresented) {
                PlayerView()
                    .environmentObject(playerViewModel)
            }
            .scrollIndicators(.hidden)
            .refreshable {
                refreshAction()
            }
        }
    }
}

var documentsUrl: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

private func load(fileName: String) -> Image? {
    let fileURL = documentsUrl.appendingPathComponent(fileName)
    do {
        let imageData = try Data(contentsOf: fileURL)
        return Image(uiImage: UIImage(data: imageData)!)
    } catch {
//        print("Error loading image : \(error)")
    }
    return nil
}



//struct ImageGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        let postItemImages = [
//            PostGridItem(thumbnailPath: "img1.jpg", processing: true, conquered: false),
//            PostGridItem(thumbnailPath: "img2.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img3.jpg", processing: true, conquered: false),
//            PostGridItem(thumbnailPath: "img4.jpg", processing: true, conquered: false),
//            PostGridItem(thumbnailPath: "img5.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img6.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img7.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img8.jpg", processing: false, conquered: false),
//            PostGridItem(thumbnailPath: "img9.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img10.jpg", processing: true, conquered: true),
//            PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: false),
//            PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: false),
//            PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
//            PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
//            PostGridItem(thumbnailPath: "img12.jpg", processing: true, conquered: false),
//            PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
//            PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
//        ]
//        ImageGrid(: postItemImages, firstItemGiantDecoration: true, shouldHaveChin: false)
//    }
//}
