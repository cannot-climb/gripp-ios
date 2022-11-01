//
//  GalleryView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/05.
//

import SwiftUI

struct GalleryView: View {
    
    @State var contextString: String
    
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
                .padding(.leading, 69).padding(.top, 6)
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color(named:"TextMasterColor"))
                }.padding(.leading, 30)
                Text("userId").font(.large_title).padding(.leading, 8)
                    .padding(.leading, 2)
            }.padding(.top, 5).padding(.bottom, 18)
            
            
            ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: false)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color("#000000").opacity(0.08), radius: 20)
            
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
        GalleryView(contextString: "Context")
    }
}
