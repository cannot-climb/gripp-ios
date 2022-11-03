//
//  ImageCell.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/27.
//

import SwiftUI

struct ImageCell: View {
    var imagePath : String?
    var processing = false
    var conquered = false
    
    var useDecoration = false
    @Binding var isPresented : Bool
    
    init(imagePath: String, processing: Bool, conquered: Bool, present: Binding<Bool>, useDecoration: Bool? = false) {
        self.imagePath = imagePath
        self.processing = processing
        self.conquered = conquered
        
        self.useDecoration = useDecoration ?? false
        self._isPresented = present
    }
    
    var body: some View {
        ZStack{
            if(processing){
                ZStack(alignment: .topTrailing){
                    GeometryReader{ gr in
                        LoadAnimationView(alwaysDark: true)
                            .padding(.all, gr.size.width*0.1)
                            .frame(width: gr.size.width*0.6, height: gr.size.width*0.6)
                            .padding(.horizontal, gr.size.width*0.2)
                            .padding(.vertical, gr.size.width*0.2)
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
                        .background(Color(named: "BackgroundMasterColor").opacity(0.8))
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        .padding(.horizontal, 8)
                    }
                }
                .background(Color("#101012"))
                .clipped()
                .aspectRatio(1, contentMode: .fit)
            }
            else{
                ZStack(alignment: .topTrailing){
                    GeometryReader{geometry in
                        Image(uiImage: UIImage(named: imagePath ?? "") ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .contentShape(Rectangle())
                    }
                    if(conquered){
                        if(useDecoration){
                            
                            HStack(alignment: .center){
                                Text("등반 성공!").font(.foot_note)
                                Image(systemName: "mappin.circle.fill")
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(Color(named: "BackgroundMasterColor").opacity(0.6))
                            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                            .backgroundStyle(.thickMaterial)
                            .padding(.horizontal, 8)
                            
                        }
                        else{
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
                        }
                    }
                }
                .onTapGesture {
                    isPresented.toggle()
                }
                .contextMenu{
                    Button {} label: {
                        Label("좋아요", systemImage: "heart")
                    }
                    Button {} label: {
                        Label("프로필 보기", systemImage: "person.circle")
                    }
                }
            }
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            HStack{
                
                ImageCell(imagePath: "img1.jpg", processing: false, conquered: true, present: .constant(true))
                
                ImageCell(imagePath: "img2.jpg", processing: true, conquered: false, present: .constant(true))
                
                ImageCell(imagePath: "img13.jpg", processing: false, conquered: false, present: .constant(true))
            }
                
            ImageCell(imagePath: "img1.jpg", processing: false, conquered: true, present: .constant(true), useDecoration: true)
            
            ImageCell(imagePath: "img1.jpg", processing: true, conquered: false, present: .constant(true), useDecoration: true)
            
            ImageCell(imagePath: "img1.jpg", processing: false, conquered: false, present: .constant(true), useDecoration: true)
        }
    }
}
