//
//  GalleryView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/05.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        let width = UIScreen.main.bounds.size.width
        
        ZStack(alignment: .center){
            Image(uiImage: UIImage(named: "img1.jpg")!)
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .frame(width: width)
            
            VStack(alignment: .leading){
                Spacer()
                Text("킬터보드 경쟁 앱").font(.context)
                    .padding(.leading, 31)
                    .opacity(0.6)
                    .foregroundColor(.white)
                    .zIndex(1)
                Spacer().frame(height: 5)
                Text("Gripp").font(.large_title)
                    .padding(.leading, 30).padding(.bottom, 10)
                    .foregroundColor(.white)
                    .zIndex(1)
                ZStack(){
                    SignupSheet()
                        .frame(width: width)
                        .padding(.bottom, 50)
                }
                .background(Color(named: "BackgroundMasterColor"))
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: .black, radius: 130)
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
        .background(.black)
        
    }
        
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
