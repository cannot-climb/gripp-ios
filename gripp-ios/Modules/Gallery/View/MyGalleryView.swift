//
//  GalleryView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/05.
//

import SwiftUI

struct MyGalleryView: View {
    
    @EnvironmentObject var galleryViewModel: GalleryViewModel
    var shouldHaveChin: Bool
    
    @State private var isLoginPresented = false
    
    let postItemImages = [
        PostGridItem(thumbnailPath: "img1.jpg", processing: true, conquered: false),
        PostGridItem(thumbnailPath: "img2.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img3.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img4.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img5.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img6.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img7.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img8.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img9.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
        PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
        PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
    ]
    
    @State private var selectedItem0 = 0
    @State private var selectedItem1 = 0
    @State private var selectedItem2 = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context).padding(.leading, 31).padding(.top, 6).foregroundColor(Color(named:"TextSubduedColor"))
            HStack{
                Text("내 정보").font(.large_title)
                Spacer()
                Button(action:{
                    galleryViewModel.logout()
                    if(UserDefaultsManager.shared.getTokens().username == nil){
                        isLoginPresented.toggle()
                    }
                }){
                    Text("로그아웃").font(.foot_note)
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 32)
                }.foregroundColor(Color(named: "TextMasterColor"))
            }.padding(.leading, 30).padding(.top, 5).padding(.bottom, 6)
            
            GeometryReader{geometry in
                HStack(alignment: .center, spacing: 6){
                    TabView(selection: $selectedItem0){
                        GalleryViewPage(title: "게시물", content: $galleryViewModel.userArticleCount, post: "개", pageIndex: 0 ,pageCount: 3)
                            .tag(0)
                        GalleryViewPage(title: "성공", content: $galleryViewModel.userArticleCount, post: "회", pageIndex: 1 ,pageCount: 3)
                            .tag(1)
                        GalleryViewPage(
                            title: "성공율",
                            content: $galleryViewModel.userArticleCertifiedCount, post: "%",
                            pageIndex: 2 ,pageCount: 3
                        ).tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .background(Color(named: "BackgroundMasterColor"))
                    .cornerRadius(14)
                    .shadow(color: Color(named: "NeuShadowLT"), radius: 6, x:-6, y:-6)
                    .shadow(color: Color(named: "NeuShadowRB"), radius: 6, x: 6, y:6)
                    .padding(.vertical, 22)
                    .padding(.horizontal, 8)
                    .frame(width: (geometry.size.width-40)/3)
                    .onTapGesture {
                        selectedItem0 = (selectedItem0+1)%3
                    }
                    
                    TabView(selection: $selectedItem1){
                        GalleryViewPage(title: "티어", pre:"V", content: $galleryViewModel.userTier,pageIndex: 0 ,pageCount: 2)
                            .tag(0)
                        GalleryViewPage(title: "점수", content: $galleryViewModel.userScore, pageIndex: 1 ,pageCount: 2)
                            .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .background(Color(named: "BackgroundMasterColor"))
                    .cornerRadius(14)
                    .shadow(color: Color(named: "NeuShadowLT"), radius: 6, x:-6, y:-6)
                    .shadow(color: Color(named: "NeuShadowRB"), radius: 6, x: 6, y:6)
                    .padding(.vertical, 22)
                    .padding(.horizontal, 8)
                    .frame(width: (geometry.size.width-40)/3)
                    .onTapGesture {
                        selectedItem1 = (selectedItem1+1)%2
                    }

                    TabView(selection: $selectedItem2){
                        GalleryViewPage(title: "전체", content: $galleryViewModel.userRank, post: "위", pageIndex: 0 ,pageCount: 2)
                            .tag(0)
                        GalleryViewPage(title: "상위", content: $galleryViewModel.userPercentile, post: "%", pageIndex: 1 ,pageCount: 2)
                            .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .background(Color(named: "BackgroundMasterColor"))
                    .cornerRadius(14)
                    .shadow(color: Color(named: "NeuShadowLT"), radius: 6, x:-6, y:-6)
                    .shadow(color: Color(named: "NeuShadowRB"), radius: 6, x: 6, y:6)
                    .padding(.vertical, 22)
                    .padding(.horizontal, 8)
                    .frame(width: (geometry.size.width-40)/3)
                    .onTapGesture {
                        selectedItem2 = (selectedItem2+1)%2
                    }
                }
                .frame(width: geometry.size.width)
                .foregroundColor(Color(named: "TextMasterColor"))
            }
            .frame(height: 130)
            .padding(.bottom, 10)
            .onAppear(perform: {
                galleryViewModel.loadUserInfo()
            })
            ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: false, shouldHaveChin: shouldHaveChin)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
            
        }
        .background(Color(named:"BackgroundSubduedColor"))
        .fullScreenCover(isPresented: $isLoginPresented, onDismiss: {
            galleryViewModel.loadUserInfo()
            galleryViewModel.loadVideoList()
        }){
            LoginView().environmentObject(LoginViewModel())
                .interactiveDismissDisabled(true)
        }
    }
}

struct MyGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        MyGalleryView(shouldHaveChin: false).environmentObject(GalleryViewModel())
    }
}
