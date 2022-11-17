//
//  ModalInfoLine.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/04.
//

import SwiftUI

struct ModalInfoLine: View {
    var imageString: String
    var pre = ""
    @Binding var text: String
    var post = ""
    var body: some View {
        HStack(alignment: .top){
            Spacer()
                .frame(width: 40)
            Image(imageString)
                .padding(.trailing, 8)
            Text(pre + text + post)
                .padding(.top, 3)
                .font(.player_vid_info)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .lineSpacing(3)
            Spacer()
                
        }.frame(minHeight: 30)
    }
}

//struct ModalInfoLine_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalInfoLine(imageString: "Person", text: "herojeff")
//    }
//}
