//
//  ScoreListView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

struct ScoreListView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer",
                           "headphones", "tv.music.note", "mic", "plus.bubble","video" ]
    private var colors: [Color] = [.yellow]
    var body: some View {
        ScrollView{
            ForEach((0...40), id: \.self){ item in
                HStack(alignment: .center, spacing: 15){
                    Text("아이디").font(.head_line)
                    Spacer()
                    Text("상위 30%, V3.78").font(.subheadline)
                    Image(systemName: "arrow.right")
                }.padding(.leading, 23).padding(.trailing, 31).padding(.top, 16).padding(.bottom, 16)
            }
        }
    }
}
