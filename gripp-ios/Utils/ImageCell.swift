//
//  ImageCell.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/27.
//

import SwiftUI

struct ImageCell: View {
    var imagePath : String
    var processing : Bool = false
    var conquered : Bool = false
    
    @Binding var isPresented : Bool
    
    init(imagePath: String, processing: Bool, conquered: Bool, present: Binding<Bool>) {
        self.imagePath = imagePath
        self.processing = processing
        self.conquered = conquered
        self._isPresented = present
    }
    
    var body: some View {
        ZStack{
            
            if(processing){
                VStack(alignment: .center){
                    GeometryReader{ gr in
                        LoadAnimationView()
                            .padding(.all, gr.size.width*0.1)
                            .frame(width: gr.size.width*0.6, height: gr.size.width*0.6)
                            .padding(.horizontal, gr.size.width*0.2)
                            .padding(.vertical, gr.size.width*0.1)
                    }
                    
                    Text("분석 중...").font(.player_id)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                        .padding(.leading, 4)
                }
                .background(Color("#101012"))
                .clipped()
                .aspectRatio(1, contentMode: .fit)
            }
            else{
                Image(uiImage: UIImage(named: imagePath)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .layoutPriority(-1)
                    
                
                HStack(alignment: .top){
                    Spacer()
                    VStack(alignment: .trailing){
                        if(conquered){
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                                .padding(.all, 10)
                                .shadow(radius: 10)
                        }
                        Spacer()
                    }
                }
                .contentShape(Rectangle())
                .clipped()
                .onTapGesture {
                    isPresented.toggle()
                }
                .aspectRatio(1, contentMode: .fit)
            }
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        ImageCell(imagePath: "img1.jpg", processing: false, conquered: true, present: .constant(true))
            .frame(width: 200, height: 200)
    }
}
