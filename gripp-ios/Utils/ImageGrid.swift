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
    
    @StateObject var galleryViewModel = GalleryViewModel()
    @State var username: String = ""
    
    @State public var videoUrl = ""
    @Binding public var noMoreData: Bool
    public var shouldHaveChin: Bool
    
    public var refreshAction: ()->()
    public var moreAction: ()->()
    
    @State private var isPlayerPresented = false
    @State private var isGalleryPresented = false
    private let gridItemLayout = [GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3)]
    
    var body: some View {
        GeometryReader{ gr in
            ScrollView{
                if(postItemImages.count > 3){
                    if(firstItemGiantDecoration){
                        HStack(spacing: 3){
                            ImageCell(articleResponse: postItemImages[0], username: $username, isPlayerPresented: $isPlayerPresented, isGalleryPresented:$isGalleryPresented, useDecoration: true)
                                .environmentObject(playerViewModel)
                                .frame(width: (gr.size.width-3)*2/3+1)
                            LazyVStack(spacing: 3){
                                ImageCell(articleResponse: postItemImages[1], username: $username, isPlayerPresented: $isPlayerPresented, isGalleryPresented:$isGalleryPresented)
                                    .environmentObject(playerViewModel)
                                ImageCell(articleResponse: postItemImages[2], username: $username, isPlayerPresented: $isPlayerPresented, isGalleryPresented:$isGalleryPresented)
                                    .environmentObject(playerViewModel)
                            }
                            .frame(width: (gr.size.width-3)/3-1)
                        }
                        .padding(.bottom, -5)
                    }
                    else{
                        HStack(spacing: 3){
                            ForEach(postItemImages[0..<3]) { item in
                                ImageCell(articleResponse: item, username: $username, isPlayerPresented: $isPlayerPresented, isGalleryPresented:$isGalleryPresented)
                                    .environmentObject(playerViewModel)
                            }
                        }
                        .padding(.bottom, -5)
                    }
                    LazyVGrid(columns: gridItemLayout, spacing: 3){
                        ForEach(postItemImages[3..<postItemImages.count], id: \.self){ item in
                            ImageCell(articleResponse: item, username: $username, isPlayerPresented: $isPlayerPresented, isGalleryPresented:$isGalleryPresented, lastAction: postItemImages.last!==item ? moreAction : nil)
                                .environmentObject(playerViewModel)
                                .clipped()
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                else if(postItemImages.count > 0){
                    LazyVGrid(columns: gridItemLayout, spacing: 3){
                        ForEach(postItemImages[0..<postItemImages.count], id: \.self){ item in
                            ImageCell(articleResponse: item, username: $username, isPlayerPresented: $isPlayerPresented, isGalleryPresented:$isGalleryPresented)
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
                if(shouldHaveChin){
                    Spacer().frame(height: DOCK_HEIGHT)
                }
            }
            .background(Color(named:"BackgroundMasterColor"))
            .fullScreenCover(isPresented: $isPlayerPresented) {
                PlayerView(removeAction: refreshAction)
                    .environmentObject(playerViewModel)
                    .onDisappear(perform: {
                        refreshAction()
                    })
            }
            .fullScreenCover(isPresented: $isGalleryPresented) {
                GalleryView(contextString: "", shouldHaveChin: false)
                    .environmentObject(galleryViewModel)
                    .onAppear(perform: {
                        galleryViewModel.username = username
                        galleryViewModel.refresh()
                    })
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
