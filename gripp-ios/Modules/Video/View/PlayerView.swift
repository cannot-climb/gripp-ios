//
//  PlayerView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/06.
//

import SwiftUI
import AVKit

struct PlayerView: View {

    var playerLayer:AVPlayerLayer
//    var videoURL = Bundle.main.url(forResource: "wide", withExtension: "mp4")!
    var videoURL = URL(string: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/sample/master.m3u8")!
    var zoomFactor:Float
    var avPlayer:AVPlayer
    var videoSize:CGSize
    
    @State var title:String = ""
    @State var description:String = ""
    
//    var geometry:CGRect

    init(){
        playerLayer = AVPlayerLayer()
        avPlayer = AVPlayer(url: videoURL)
//        videoSize = AVURLAsset(url: videoURL).videoSize!
        videoSize = CGSize(width: 9, height: 16)
        zoomFactor = Float(UIScreen.main.bounds.size.height / videoSize.height)
        
        playerLayer.player = avPlayer
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        
//        geometry = UIScreen.main.bounds
        
        
        
        
        
    }
    
    var body: some View {
        ZStack{
            GeometryReader{geometry in
                VideoPlayer(player: avPlayer)
                    .frame(width: videoSize.width*CGFloat(zoomFactor), height: videoSize.height*CGFloat(zoomFactor))
                    .offset(x: -0.5*videoSize.width*CGFloat(zoomFactor))
                
                VStack{
                    VideoPlayer(player: avPlayer)
                        .frame(width: geometry.size.width, height: videoSize.height*CGFloat(Float(UIScreen.main.bounds.size.width / videoSize.width))/1.32)
                    Spacer()
                    HStack{
                        Image(systemName: "arrow.left").onTapGesture {
                            
                        }
                        .foregroundColor(Color(.white))
                        Text("영상 제목").font(.large_title).foregroundColor(Color(.white))
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("아이디").font(.player_id).foregroundColor(Color("#5889FF")).padding(.bottom, 1)
                            Text("상위 20%, V6.43").font(.player_id_info).foregroundColor(Color(.white))
                        }
                    }.padding(.leading, 30)
                        .padding(.trailing, 30)
                    HStack{
                        VStack(alignment: .leading){
                            Text("2022/09/12, Course String").font(.player_vid_info).foregroundColor(Color(.white)).padding(.bottom, 1)
                            Text("난이도 V14, 70º").font(.player_vid_info).foregroundColor(Color(.white))
                        }
                        Spacer()
                        Image(systemName: "pencil").foregroundColor(Color(.white))
                            .scaledToFill()
                            .frame(width: 30,height: 30)
                        Image(systemName: "trash").foregroundColor(Color(.white))
                            .scaledToFill()
                            .frame(width: 30,height: 30)
                    }.padding(.leading, 40)
                        .padding(.top, 6)
                        .padding(.trailing, 35)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ornare posuere metus. Donec posuere porta tincidunt. Duis mollis nisi a felis molestie sodales. Integer ac est enim. Duis scelerisque et sapien eget rhoncus. Sed convallis libero sed lacus hendrerit, at venenatis diam elementum. Cras vel orci ac est pellentesque vehicula id eget nibh.")
                        .font(.player_vid_description)
                        .foregroundColor(.white).padding(.leading, 40)
                        .padding(.top, 10)
                        .padding(.trailing, 30)
                }
                .frame(width: geometry.size.width)
                .background(Color("#000000").opacity(0.7)).background(.thinMaterial)
            }
        }
    }
}


extension AVAsset {

    var videoSize: CGSize? {
        tracks(withMediaType: .video).first.flatMap {
            tracks.count > 0 ? $0.naturalSize.applying($0.preferredTransform) : nil
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
