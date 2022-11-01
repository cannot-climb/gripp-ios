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
    @State private var zoomFactor:Float = 1.0
    @State private var avPlayer:AVPlayer?
    @State private var videoSize:CGSize = CGSize(width: 1, height: 0)
    
    @State var selectedItems: [PhotosPickerItem] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Button(action: {self.presentationMode.wrappedValue.dismiss()}){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color(named: "TextMasterColor"))
                }
                Text("영상 올리기").font(.large_title).padding(.leading, 8)
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
                        if(selectedItems.count != 0){
                            VStack{
                                VideoPlayer(player: avPlayer)
                                    .frame(width: min(geometry.size.height / videoSize.height * videoSize.width, geometry.size.width), height: min(geometry.size.width / videoSize.width * videoSize.height, geometry.size.height))
                                    .clipped()
                                    .cornerRadius(20)
                                    .blur(radius: 30)
                                    .opacity(0.4)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    Spacer().frame(width: 20)
                }
                HStack(alignment: .center){
                    Spacer().frame(width: 40)
                    
                        if(selectedItems.count == 0){
                            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .videos){
                                Image(systemName: "video.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(.vertical, 30)
                                    .padding(.horizontal, (UIScreen.main.bounds.width - 90 - 20)/2)
                                    .foregroundColor(Color(named: "TextMasterColor"))
                            }
                            
                            
                        }
                        else{
                            //main video
                            ZStack{
                                LoadAnimationView(alwaysDark: false)
                                    .frame(width: 100, height: 100)
                                    
                                
                                GeometryReader{geometry in
                                    VStack{
                                        VideoPlayer(player: avPlayer)
                                            .frame(width: min(geometry.size.height / videoSize.height * videoSize.width, geometry.size.width), height: min(geometry.size.width / videoSize.width * videoSize.height, geometry.size.height))
                                            .clipped()
                                            .cornerRadius(20)
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            }
                            .contentShape(Rectangle())
                        }
                    
                    Spacer().frame(width: 40)
                }
            }.padding(.top, 20).onChange(of: selectedItems) {
                newValue in
                guard let item = selectedItems.first else { return }
                item.loadTransferable(type: Movie.self) { result in
                    switch result {
                    case .success(let movie):
                        if let movie = movie {
                            avPlayer = AVPlayer(url: movie.url)
                            avPlayer!.playImmediately(atRate: 1.0)
                            
                            let videoAssetSource = AVAsset.init(url: movie.url)
                            videoSize.width = abs(videoAssetSource.videoSize!.width)
                            videoSize.height = abs(videoAssetSource.videoSize!.height)
                            zoomFactor = Float(UIScreen.main.bounds.size.height / videoSize.height)
                            print(videoSize)
                        } else {
                            print("movie is nil")
                        }
                    case .failure(let failure):
                        fatalError("\(failure)")
                    }
                }
            }
            
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


extension AVAsset {
    var videoSize: CGSize? {
        tracks(withMediaType: .video).first.flatMap {
            tracks.count > 0 ? $0.naturalSize.applying($0.preferredTransform) : nil
        }
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
