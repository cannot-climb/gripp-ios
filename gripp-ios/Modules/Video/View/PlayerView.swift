//
//  PlayerView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/06.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    //    var playerLayer:AVPlayerLayer
    var videoPortraitURL = URL(string: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/sample/master.m3u8")!
    var videoLandScapeURL = URL(string: "https://file-examples.com/storage/fea4ef07a863619cfa0b308/2017/04/file_example_MP4_1280_10MG.mp4")!
    @State var avPlayer:AVPlayer?
    
    @State var modalExpanded: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title:String = ""
    @State var description:String = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                //video
                GeometryReader{geometry in
                    VStack{
                        VideoPlayer(player: avPlayer)
                            .onAppear(perform: {
                                avPlayer?.playImmediately(atRate: 1.0)
                            })
                            .onDisappear(perform: {
                                avPlayer?.pause()
                            })
                            .frame(width: geometry.size.width, height: geometry.size.width/9*16)
                            .allowsHitTesting(false)
                        
                        Color.black
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    .background(.black)
                }

                DanglingModal(presentationMode: _presentationMode, isExpanded: $modalExpanded, avPlayer: avPlayer)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return (self.timeControlStatus == AVPlayer.TimeControlStatus.playing)
    }
}
