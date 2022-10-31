//
//  UploadView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct UploadView: View {
    @State var title = ""
    @State var description = ""
    @State var angle = ""
    @State var difficulty = ""
    
    var imagePath: String
    
    @Environment(\.presentationMode) var presentationMode
    
    init(imagePath: String){
        self.imagePath = imagePath
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Button(action: {self.presentationMode.wrappedValue.dismiss()}){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color(named: "TextMasterColor"))
                }
                Text("영상 올리기").font(.large_title)
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color("#BE1F00"))
                    .cornerRadius(40)
                    .shadow(color: Color("#FF0000").opacity(0.25), radius: 12)
            }.padding(.leading, 30)
                .padding(.top, 20)
                .padding(.trailing, 20)
            
            ZStack{
                HStack{
                    Spacer().frame(width: 20)
                    Image(uiImage: UIImage(named: imagePath)!)
                        .resizable()
                        .cornerRadius(20)
                        .clipped()
                        .blur(radius: 30)
                        .opacity(0.25)
                    Spacer().frame(width: 20)
                }
                HStack{
                    Spacer().frame(width: 50)
                    Image(uiImage: UIImage(named: imagePath)!)
                        .resizable()
                        .clipped()
                        .cornerRadius(20)
                        .scaledToFit()
                    Spacer().frame(width: 50)
                }
            }.padding(.top, 20)
            HStack(spacing: 15){
                Text("제목").font(.textfield_leading)
                TextField("", text: $title).overlay(VStack{Divider().offset(x: 0, y: 15)})
            }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
            HStack(spacing: 15){
                Text("설명").font(.textfield_leading)
                TextField("", text: $description).overlay(VStack{Divider().offset(x: 0, y: 15)})
            }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
            HStack(spacing: 20){
                HStack(spacing: 15){
                    Text("각도").font(.textfield_leading)
                    TextField("", text: $angle).overlay(VStack{Divider().offset(x: 0, y: 15)}) //todo : swap to dropdown
                }
                HStack(spacing: 15){
                    Text("난이도").font(.textfield_leading)
                    TextField("", text: $difficulty).overlay(VStack{Divider().offset(x: 0, y: 15)}) //todo : swap to dropdown
                }
            }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
            
            
//            let width = UIScreen.main.bounds.size.width
//            let cellWidth = width/3
//            HStack(spacing: 20){
//                HStack{
//                    Text("각도").font(.textfield_leading)
//                        .padding(.leading, 15)
//                        .padding(.vertical, 10)
//                    Spacer()
//                    Image(systemName: "arrow.right")
//                        .padding(.vertical, 10)
//                        .padding(.trailing, 15)
//                }
//                .frame(width: cellWidth, height: 50)
//                .background(.white)
//                .cornerRadius(14)
//                .shadow(color: Color(.black).opacity(0.16), radius: 10)
//                HStack{
//                    Text("난이도").font(.textfield_leading)
//                        .padding(.leading, 15)
//                        .padding(.vertical, 10)
//                    Spacer()
//                    Image(systemName: "arrow.right")
//                        .padding(.vertical, 10)
//                        .padding(.trailing, 15)
//                }
//                .frame(width: cellWidth, height: 50)
//                .background(.white)
//                .cornerRadius(14)
//                .shadow(color: Color(.black).opacity(0.16), radius: 10)
//            }
//            .padding(.top, 35)
//            .padding(.horizontal, 20)
            
            
            
            Spacer()
        }
        .padding(.bottom, 20)
        .background(Color(named:"BackgroundMasterColor"))
    }
}


struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(imagePath: "img9.jpg")
    }
}
