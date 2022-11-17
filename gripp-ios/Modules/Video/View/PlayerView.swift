//
//  PlayerView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/06.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    @State var modalExpanded: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title:String = ""
    @State var description:String = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                let avPlayer = AVPlayer(url: URL(string: playerViewModel.videoUrl)!)
//                let k = avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused
                //video
                GeometryReader{geometry in
                    VStack{
                        VideoPlayer(player: avPlayer)
                            .onAppear(perform: {
                                avPlayer.playImmediately(atRate: 1.0)
                            })
                            .onDisappear(perform: {
                                avPlayer.pause()
                            })
                            .frame(width: geometry.size.width, height: geometry.size.width/9*16)
                            .allowsHitTesting(false)
                        
                        Color.black
                            .edgesIgnoringSafeArea(.bottom)
                    }
                    .background(.black)
                }

                DanglingModal(presentationMode: _presentationMode, isExpanded: $modalExpanded, avPlayer: avPlayer)
                    .environmentObject(playerViewModel)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView().environmentObject(PlayerViewModel())
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return (self.timeControlStatus == AVPlayer.TimeControlStatus.playing)
    }
}
