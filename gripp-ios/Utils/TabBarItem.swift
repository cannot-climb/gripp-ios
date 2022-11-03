//
//  TabBarItem.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/03.
//

import SwiftUI

struct TabBarItem: View {
    let title: String
    let isSelected: Bool
    let icon: Image
    var body: some View {
        VStack {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .animation(.default)
            
            Spacer().frame(height: 4)
            
            Text(title)
                .foregroundColor(isSelected ? .black : .gray)
                .font(.foot_note)
        }
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(title: "test", isSelected: false, icon: Image(systemName: "square.text.square"))
    }
}
