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
    var videoURL = URL(string: "https://objectstorage.ap-seoul-1.oraclecloud.com/n/cngzlmggdnp2/b/gripp/o/videos/sample/master.m3u8")!
    var zoomFactor:Float
    var avPlayer:AVPlayer
    var videoSize:CGSize
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title:String = ""
    @State var description:String = ""
    
    init(){
        //        playerLayer = AVPlayerLayer()
        avPlayer = AVPlayer(url: videoURL)
        videoSize = CGSize(width: 9, height: 16)
        zoomFactor = Float(UIScreen.main.bounds.size.height / videoSize.height)
        
        //        playerLayer.player = avPlayer
        //        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                GeometryReader{geometry in
                    VideoPlayer(player: avPlayer)
                        .frame(minWidth: videoSize.width*CGFloat(zoomFactor), minHeight: videoSize.height*CGFloat(zoomFactor))
                        .ignoresSafeArea()
                        .offset(x: -0.5*(videoSize.width*CGFloat(zoomFactor) - geometry.size.width), y: -0.5*(videoSize.height*CGFloat(zoomFactor) - geometry.size.height))
                    
                    VStack{
                        VideoPlayer(player: avPlayer)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onAppear(perform: {
                                avPlayer.playImmediately(atRate: 1.0)
                            })
                        
                        VStack{
                            HStack{
                                Button(action:{
                                    self.presentationMode.wrappedValue.dismiss()
                                    avPlayer.pause()
                                }){
                                    Image(systemName: "arrow.left").foregroundColor(Color(named:"TextMasterColor"))
                                }
                                Text("영상 제목").font(.large_title).padding(.leading, 8)
                                Spacer()
                                VStack(alignment: .trailing){
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                        avPlayer.pause()
                                    }){
                                        NavigationLink(destination: GalleryView().navigationBarBackButtonHidden(true)) {
                                            Text("아이디").font(.player_id).foregroundColor(Color(named:"AccentMasterColor")).padding(.bottom, 1)
                                        }
                                        .onTapGesture(perform: {avPlayer.pause()})
                                    }
                                    Text("상위 20%, V6.43").font(.player_id_info)
                                }
                            }
                            .frame(maxHeight: 50)
                            .padding(.top, 10)
                            .padding(.horizontal, 30)
                            
                            HStack{
                                VStack(alignment: .leading){
                                    Text("2022/09/12, Course String").font(.player_vid_info).foregroundColor(Color(named: "TextSubduedColor"))
                                        .padding(.bottom, 1)
                                    Text("난이도 V14, 70º").font(.player_vid_info).foregroundColor(Color(named: "TextSubduedColor"))
                                }
                                Spacer()
                                Button(action:{
                                    self.presentationMode.wrappedValue.dismiss()
                                    avPlayer.pause()
                                }){
                                    Image(systemName: "trash").foregroundColor(Color(named:"TextMasterColor"))
                                        .scaledToFill()
                                        .frame(width: 30,height: 30)
                                }
                            }
                            .padding(.leading, 40)
                            .padding(.top, 6)
                            .padding(.trailing, 35)
                            ScrollView{
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ornare posuere metus. Donec posuere porta tincidunt. Duis mollis nisi a felis molestie sodales. Integer ac est enim. Duis scelerisque et sapien eget rhoncus. Sed convallis libero sed lacus hendrerit, at venenatis diam elementum. Cras vel orci ac est pellentesque vehicula id eget nibh.")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(named:"TextMasterColor"))
                            }
                            .frame(maxHeight: 150)
                            .font(.player_vid_description)
                            .padding(.leading, 40)
                            .padding(.top, 10)
                            .padding(.trailing, 30)
                        }
                    }
                    .frame(width: geometry.size.width)
                    .background(Color(named:"BackgroundMasterColor").opacity(0.5))
                    .background(.thinMaterial)
                }
            }
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
