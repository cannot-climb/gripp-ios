//
//  UploadView.swift
//  gripp-ios
//
//  https://www.youtube.com/watch?v=crULPMS7Uxs
//
//  Created by 조준오 on 2022/10/04
//

import Foundation
import SwiftUI
import PhotosUI
import AVKit

struct UploadView: View {
    @State var title = ""
    @State var description = ""
    @State var angle = ""
    @State var difficulty = ""
    
//    private var playerLayer:AVPlayerLayer
    private var zoomFactor:Float
    @State private var avPlayer:AVPlayer?
    private var videoSize:CGSize
    
    @State var selectedItems: [PhotosPickerItem] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    init(){
//        playerLayer = AVPlayerLayer()
        videoSize = CGSize(width: 16, height: 9)
        zoomFactor = Float(UIScreen.main.bounds.size.height / videoSize.height)
        
//        playerLayer.player = avPlayer
//        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
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
            }.padding(.leading, 30).padding(.top, 20).padding(.trailing, 20)
            
            ZStack{
                HStack(alignment: .center){
                    Spacer().frame(width: 20)
                    
                    //background blurry video
                    GeometryReader{geometry in
                        VStack{
                            VideoPlayer(player: avPlayer)
                                .frame(width: min(geometry.size.height / videoSize.height * videoSize.width, geometry.size.width), height: min(geometry.size.width / videoSize.width * videoSize.height, geometry.size.height))
                                .clipped()
                                .cornerRadius(20)
                                .blur(radius: 30)
                                .opacity(0.4)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    Spacer().frame(width: 20)
                }
                HStack(alignment: .center){
                    Spacer().frame(width: 40)
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .videos){
                        //main video
                        GeometryReader{geometry in
                            VStack{
                                VideoPlayer(player: avPlayer)
                                    .frame(width: min(geometry.size.height / videoSize.height * videoSize.width, geometry.size.width), height: min(geometry.size.width / videoSize.width * videoSize.height, geometry.size.height))
                                    .clipped()
                                    .cornerRadius(20)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }.onChange(of: selectedItems) {
                        newValue in
                        guard let item = selectedItems.first else { return }
                        item.loadTransferable(type: Movie.self) { result in
                            switch result {
                            case .success(let movie):
                                if let movie = movie {
                                    avPlayer = AVPlayer(url: movie.url)
                                    avPlayer!.playImmediately(atRate: 1.0)
                                } else {
                                    print("movie is nil")
                                }
                            case .failure(let failure):
                                fatalError("\(failure)")
                            }
                        }
                    }
                    Spacer().frame(width: 40)
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
            
            
            Spacer()
        }
        .padding(.bottom, 20)
        .background(Color(named:"BackgroundMasterColor"))
    }
    
    
}


struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}


struct Movie: Transferable {
  let url: URL

  static var transferRepresentation: some TransferRepresentation {
    FileRepresentation(contentType: .movie) { movie in
      SentTransferredFile(movie.url)
    } importing: { receivedData in
      let fileName = receivedData.file.lastPathComponent
      let copy: URL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

      if FileManager.default.fileExists(atPath: copy.path) {
        try FileManager.default.removeItem(at: copy)
      }

      try FileManager.default.copyItem(at: receivedData.file, to: copy)
      return .init(url: copy)
    }
  }
}
