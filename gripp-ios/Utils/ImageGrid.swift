//
//  ImageGrid.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct ImageGrid: View {
    public var postItemImages : [PostGridItem]
    private var gridItemLayout = [GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3)]
    public var firstItemGiantDecoration = false
    
    @State private var isPresented = false
    var shouldHaveChin: Bool
    
    init(postItemImages: [PostGridItem], firstItemGiantDecoration: Bool, shouldHaveChin: Bool?) {
        self.postItemImages = postItemImages
        self.firstItemGiantDecoration = firstItemGiantDecoration
        self.shouldHaveChin = shouldHaveChin ?? false
    }
    
    var body: some View {
        
        GeometryReader{ gr in
            ScrollView{
                if(firstItemGiantDecoration){
                    HStack(spacing: 3){
                        let item = postItemImages[0..<3]
                        ImageCell(imagePath: item[0].thumbnailPath, processing: item[0].processing, conquered: item[0].conquered, present: $isPresented, useDecoration: true)
                            .frame(width: (gr.size.width-3)*2/3+1)
                        VStack(spacing: 3){
                            ImageCell(imagePath: item[1].thumbnailPath, processing: item[1].processing, conquered: item[1].conquered, present: $isPresented)
                            ImageCell(imagePath: item[2].thumbnailPath, processing: item[2].processing, conquered: item[2].conquered, present: $isPresented)
                        }
                        .frame(width: (gr.size.width-3)/3-1)
                    }
                    .padding(.bottom, -5)
                }
                else{
                    HStack(spacing: 3){
                        ForEach(postItemImages[0..<3]) { item in
                            ImageCell(imagePath: item.thumbnailPath, processing: item.processing, conquered: item.conquered, present: $isPresented)
                        }
                    }
                    .padding(.bottom, -5)
                }
                LazyVGrid(columns: gridItemLayout, spacing: 3){
                    ForEach(postItemImages[3..<postItemImages.count], id: \.self){ item in
                        ImageCell(imagePath: item.thumbnailPath, processing: item.processing, conquered: item.conquered, present: $isPresented)
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                if(shouldHaveChin){
                    Spacer().frame(height: DOCK_HEIGHT)
                }
            }.background(Color(named:"BackgroundMasterColor"))
                .sheet(isPresented: $isPresented) {
                    PlayerView()
                }
                .scrollIndicators(.hidden)
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
        print("Error loading image : \(error)")
    }
    return nil
}



struct ImageGrid_Previews: PreviewProvider {
    static var previews: some View {
        let postItemImages = [
            PostGridItem(thumbnailPath: "img1.jpg", processing: true, conquered: false),
            PostGridItem(thumbnailPath: "img2.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img3.jpg", processing: true, conquered: false),
            PostGridItem(thumbnailPath: "img4.jpg", processing: true, conquered: false),
            PostGridItem(thumbnailPath: "img5.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img6.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img7.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img8.jpg", processing: false, conquered: false),
            PostGridItem(thumbnailPath: "img9.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img10.jpg", processing: true, conquered: true),
            PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: false),
            PostGridItem(thumbnailPath: "img12.jpg", processing: false, conquered: false),
            PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
            PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img10.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img11.jpg", processing: false, conquered: true),
            PostGridItem(thumbnailPath: "img12.jpg", processing: true, conquered: false),
            PostGridItem(thumbnailPath: "img13.jpg", processing: false, conquered: false),
            PostGridItem(thumbnailPath: "img14.jpg", processing: false, conquered: true),
        ]
        ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: true, shouldHaveChin: false)
    }
}
