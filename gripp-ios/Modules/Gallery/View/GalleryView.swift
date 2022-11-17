//
//  GalleryView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/05.
//

import SwiftUI

struct GalleryView: View {
    
    @State var contextString: String
    
    let shouldHaveChin: Bool
    @State private var selectedItem0 = 0
    @State private var selectedItem1 = 0
    @State private var selectedItem2 = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
            
            Text(contextString).font(.context)
                .foregroundColor(Color(named:"TextSubduedColor"))
                .padding(.leading, 65).padding(.top, 6)
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image("ArrowLeft").foregroundColor(Color(named:"TextMasterColor"))
                }.padding(.leading, 30).padding(.trailing, 6)
                Text("userId").font(.large_title)
            }.padding(.top, 5).padding(.bottom, 6)
            
            GeometryReader{geometry in
                HStack(alignment: .center, spacing: 6){
//                    TabView(selection: $selectedItem0){
//                        GalleryViewPage(title: "게시물", content: "20개",pageIndex: 0 ,pageCount: 3)
//                            .tag(0)
//                        GalleryViewPage(title: "성공", content: "12회",pageIndex: 1 ,pageCount: 3)
//                            .tag(1)
//                        GalleryViewPage(title: "성공율", content: "60%",pageIndex: 2 ,pageCount: 3)
//                            .tag(2)
//                    }
//                    .tabViewStyle(.page(indexDisplayMode: .never))
//                    .background(Color(named: "BackgroundMasterColor"))
//                    .cornerRadius(14)
//                    .shadow(color: Color(named: "NeuShadowLT"), radius: 6, x:-6, y:-6)
//                    .shadow(color: Color(named: "NeuShadowRB"), radius: 6, x: 6, y:6)
//                    .padding(.vertical, 22)
//                    .padding(.horizontal, 8)
//                    .frame(width: (geometry.size.width-40)/3)
//                    .onTapGesture {
//                        selectedItem0 = (selectedItem0+1)%3
//                    }
//                    
//                    TabView(selection: $selectedItem1){
//                        GalleryViewPage(title: "티어", content: "V12",pageIndex: 0 ,pageCount: 2)
//                            .tag(0)
//                        GalleryViewPage(title: "점수", content: "11.54",pageIndex: 1 ,pageCount: 2)
//                            .tag(1)
//                    }
//                    .tabViewStyle(.page(indexDisplayMode: .never))
//                    .background(Color(named: "BackgroundMasterColor"))
//                    .cornerRadius(14)
//                    .shadow(color: Color(named: "NeuShadowLT"), radius: 6, x:-6, y:-6)
//                    .shadow(color: Color(named: "NeuShadowRB"), radius: 6, x: 6, y:6)
//                    .padding(.vertical, 22)
//                    .padding(.horizontal, 8)
//                    .frame(width: (geometry.size.width-40)/3)
//                    .onTapGesture {
//                        selectedItem1 = (selectedItem1+1)%2
//                    }
//                    
//                    TabView(selection: $selectedItem2){
//                        GalleryViewPage(title: "전체", content: "20위",pageIndex: 0 ,pageCount: 2)
//                            .tag(0)
//                        GalleryViewPage(title: "상위", content: "90%",pageIndex: 1 ,pageCount: 2)
//                            .tag(1)
//                    }
//                    .tabViewStyle(.page(indexDisplayMode: .never))
//                    .background(Color(named: "BackgroundMasterColor"))
//                    .cornerRadius(14)
//                    .shadow(color: Color(named: "NeuShadowLT"), radius: 6, x:-6, y:-6)
//                    .shadow(color: Color(named: "NeuShadowRB"), radius: 6, x: 6, y:6)
//                    .padding(.vertical, 22)
//                    .padding(.horizontal, 8)
//                    .frame(width: (geometry.size.width-40)/3)
//                    .onTapGesture {
//                        selectedItem2 = (selectedItem2+1)%2
//                    }
                }
                .frame(width: geometry.size.width)
                .foregroundColor(Color(named: "TextMasterColor"))
            }
            .frame(height: 130)
            .padding(.bottom, 10)
            
            ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: false, shouldHaveChin: shouldHaveChin)
                .cornerRadius(24, corners: shouldHaveChin ? [.topLeft, .topRight] : .allCorners)
                .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
            
        }
        .background(Color(named:"BackgroundSubduedColor"))
        
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(contextString: "Context", shouldHaveChin: false)
    }
}
