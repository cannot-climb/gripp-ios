//
//  ImageCell.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/27.
//

import SwiftUI
import CachedAsyncImage

struct ImageCell: View {
    
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var articleResponse: ArticleResponse
    
    var imagePath = ""
    var processing = false
    var conquered = false
    var videoUrl = ""
    
    @Binding var username: String
    
    var useDecoration = false
    @Binding var isPlayerPresented : Bool
    @Binding var isGalleryPresented : Bool
    
    init(articleResponse: ArticleResponse, username: Binding<String>, isPlayerPresented: Binding<Bool>, isGalleryPresented: Binding<Bool>, useDecoration: Bool? = false) {
        self.imagePath = articleResponse.video!.thumbnailUrl!
        self.processing = articleResponse.video!.status! == "PREPROCESSING"
        self.conquered = articleResponse.video!.status! == "CERTIFIED"
        self.videoUrl = articleResponse.video!.streamingUrl!
        self.articleResponse = articleResponse
        
        self._username = username
        
        self.useDecoration = useDecoration ?? false
        self._isPlayerPresented = isPlayerPresented
        self._isGalleryPresented = isGalleryPresented
    }
    
    var body: some View {
        ZStack{
            if(processing){
                ZStack(alignment: .topTrailing){
                    GeometryReader{ gr in
                        LoadAnimationView(alwaysDark: true)
                            .frame(width: gr.size.width*0.6, height: gr.size.width*0.6)
                            .padding(.all, gr.size.width*0.2)
                            .colorScheme(.dark)
                    }
                    if(useDecoration){
                        HStack(alignment: .center){
                            Text("처리 중").font(.foot_note)
                            Image(systemName: "person.and.background.dotted")
                                .offset(CGSize(width: 0, height: -1))
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .background(Color(named: "TextMasterColor").opacity(0.2))
                        .background(.ultraThinMaterial)
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        .padding(.horizontal, 8)
                    }
                    else{
                        Image(systemName: "person.and.background.dotted")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 24, height: 18)
                            .padding(.top, 12)
                            .padding(.trailing, 10)
                            .shadow(radius: 10)
                    }
                }
                .background(Color("#101012"))
                .clipped()
                .aspectRatio(1, contentMode: .fit)
            }
            else{
                ZStack(alignment: .topTrailing){
                    GeometryReader{geometry in
                        CachedAsyncImage(url: URL(string: imagePath), urlCache: .imageCache, transaction: Transaction(animation: .default)) { phase in
                            switch phase {
                            case .empty:
                                LoadAnimationView(alwaysDark: false)
                                    .padding(.all, 20)
                            case .success(let image):
                                image.resizable()
                                    .scaledToFill()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .contentShape(Rectangle())
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    if(conquered){
                        if(useDecoration){
                            
                            HStack(alignment: .center){
                                Text("등반 성공!").font(.foot_note)
                                Image("ConquerOutlined")
                                    .padding(.horizontal, -2)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(Color(named: "BackgroundMasterColor").opacity(0.6))
                            .background(.ultraThinMaterial)
                            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                            .shadow(radius: 10)
                            .padding(.horizontal, 8)
                            
                        }
                        else{
                            HStack(alignment: .top){
                                Spacer()
                                VStack(alignment: .trailing){
                                    if(conquered){
                                        Image("ConquerFilled")
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                            .padding(.top, 8)
                                            .padding(.trailing, 6)
                                            .shadow(radius: 10)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .onTapGesture {
                    playerViewModel.setVideoThumbnail(url: self.imagePath)
                    playerViewModel.setVideoUrl(videoUrl: videoUrl)
                    playerViewModel.setVideoInfo(articleResponse: articleResponse)
                    isPlayerPresented.toggle()
                }
                .contextMenu{
                    Button {
                        playerViewModel.toggleFavorite()
                    } label: {
                        if(playerViewModel.videoFavorite){
                            Label("좋아요 해제", systemImage: "heart.fill")
                        }
                        else{
                            Label("좋아요", systemImage: "heart")
                        }
                    }
                    Button {
                        playerViewModel.setVideoInfo(articleResponse: articleResponse)
                        username = playerViewModel.videoUser
                        isGalleryPresented.toggle()
                    } label: {
                        Label("프로필 보기", systemImage: "person.circle")
                    }
                }
            }
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }
}

//struct ImageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            HStack{
//                
//                ImageCell(imagePath: "img1.jpg", processing: false, conquered: true, present: .constant(true))
//                
//                ImageCell(imagePath: "img2.jpg", processing: true, conquered: false, present: .constant(true))
//                
//                ImageCell(imagePath: "img13.jpg", processing: false, conquered: false, present: .constant(true))
//            }
//                
//            ImageCell(imagePath: "img1.jpg", processing: false, conquered: true, present: .constant(true), useDecoration: true)
//            
//            ImageCell(imagePath: "img1.jpg", processing: true, conquered: false, present: .constant(true), useDecoration: true)
//            
//            ImageCell(imagePath: "img1.jpg", processing: false, conquered: false, present: .constant(true), useDecoration: true)
//        }
//    }
//}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
