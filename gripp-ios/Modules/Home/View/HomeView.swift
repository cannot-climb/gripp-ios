//
//  HomeView.swift
//  gripp-ios
//
//  https://stackoverflow.com/questions/67616887/how-to-align-swiftui-menu-item-with-checkmark-in-macos
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let shouldHaveChin : Bool
    @StateObject var viewRouter: ViewRouter
    
    let postItemImages = [
        PostGridItem(thumbnailPath: "img1.jpg", processing: false, conquered: true),
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
            Button(action:{viewRouter.currentPage = .myGallery}){
                Text(homeViewModel.titleUserName).font(.large_title)
                Image("ArrowRight")
            }.padding(.leading, 30).padding(.top, 5)
                .foregroundColor(Color(named: "TextMasterColor"))
            HStack(alignment: .center){
                Text("userInfoString").font(.foot_note)
                    .padding(.leading, 32)
                
                Spacer()
                
                Menu {
                    let bind0 = Binding<Bool>(
                        get:{homeViewModel.selectedDifficulties[0]},
                        set:{
                            homeViewModel.selectedDifficulties[0] = $0
                            homeViewModel.loadVideoList()
                    })
                    Toggle(isOn: bind0) {
                        Text("V16 - V20")
                    }
                    
                    let bind1 = Binding<Bool>(
                        get:{homeViewModel.selectedDifficulties[1]},
                        set:{
                            homeViewModel.selectedDifficulties[1] = $0
                            homeViewModel.loadVideoList()
                    })
                    Toggle(isOn: bind1) {
                        Text("V11 - V15")
                    }
                    
                    let bind2 = Binding<Bool>(
                        get:{homeViewModel.selectedDifficulties[2]},
                        set:{
                            homeViewModel.selectedDifficulties[2] = $0
                            homeViewModel.loadVideoList()
                    })
                    Toggle(isOn: bind2) {
                        Text("V6 - V10")
                    }
                    
                    let bind3 = Binding<Bool>(
                        get:{homeViewModel.selectedDifficulties[3]},
                        set:{
                            homeViewModel.selectedDifficulties[3] = $0
                            homeViewModel.loadVideoList()
                    })
                    Toggle(isOn: bind3) {
                        Text("V0 - V5")
                    }
                } label: {
                    Text("난이도").font(.foot_note)
                        .foregroundColor(Color(named: "TextMasterColor"))
                    Image("Sort")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 32)
                        .foregroundColor(Color(named: "TextMasterColor"))
                }
            }.padding(.top, 4).padding(.bottom, 16)
            
            ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: true, shouldHaveChin: shouldHaveChin)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
        }
        .background(Color(named:"BackgroundSubduedColor"))
        .onAppear(perform: {
            homeViewModel.loadTitleInfo()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(shouldHaveChin: false, viewRouter: ViewRouter())
    }
}
