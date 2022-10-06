//
//  ImageGrid.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct ImageGrid: View {
    
    private var imagePaths =  ["img1.jpg","img2.jpg","img3.jpg","img4.jpg","img5.jpg","img6.jpg","img7.jpg","img8.jpg","img9.jpg","img10.jpg","img11.jpg","img12.jpg","img13.jpg","img14.jpg"]
    private var gridItemLayout = [GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3),GridItem(.flexible(minimum: 40), spacing: 3)]
    
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItemLayout, spacing: 3){
                ForEach((0...40), id: \.self){ item in
                    GeometryReader{ gr in
                        Image(uiImage: UIImage(named: imagePaths[item % imagePaths.count])!)
                            .resizable()
                            .scaledToFill()
                    }
                    .clipped()
                    .aspectRatio(1, contentMode: .fit)
                }
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
        print("Error loading image : \(error)")
    }
    return nil
}
