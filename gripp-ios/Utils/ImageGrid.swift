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
    
    init(postItemImages: [PostGridItem], firstItemGiantDecoration: Bool) {
        self.postItemImages = postItemImages
        self.firstItemGiantDecoration = firstItemGiantDecoration
    }
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItemLayout, spacing: 3){
                ForEach(postItemImages, id: \.self){ item in
                    GeometryReader{ gr in
                        ImageCell(imagePath: item.thumbnailPath, processing: item.processing, conquered: item.conquered, present: $isPresented)
                    }
                    .clipped()
                    .aspectRatio(1, contentMode: .fit)
                }
            }
            
        }.background(Color(named:"BackgroundMasterColor"))
            .sheet(isPresented: $isPresented) {
                PlayerView()
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
        ImageGrid(postItemImages: postItemImages, firstItemGiantDecoration: true)
    }
}
