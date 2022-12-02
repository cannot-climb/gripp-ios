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
    @EnvironmentObject var uploadViewModel: UploadViewModel
    
    @State var title = ""
    @State var description = ""
    @State var angle = 0
    @State var difficulty = 0
    
    let angles = Array(0...14).map({$0*5})
    let difficulties = Array(0...19)
    
    //    private var playerLayer:AVPlayerLayer
    @State private var zoomFactor:Float = 1.0
    @State private var avPlayer:AVPlayer?
    @State private var videoSize:CGSize = CGSize(width: 1, height: 0)
    
    @State var movieURL: URL?
    @State var movieFileName: String?
    
    @State var selectedItems: [PhotosPickerItem] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            GeometryReader{ geometry in
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height*uploadViewModel.progressPercentile)
                    .foregroundColor(Color(named: "BackgroundSubduedColor"))
                    .offset(y: geometry.size.height*(1-uploadViewModel.progressPercentile))
            }
            .edgesIgnoringSafeArea(.bottom)
            VStack(alignment: .leading, spacing: 0){
                //top bar
                HStack{
                    if(uploadViewModel.uploadingNow){
                        Image("ArrowLeft").foregroundColor(Color(named: "TextMasterColor"))
                            .padding(.leading, 10).padding(.trailing, 6)
                            .opacity(0.4)
                            .disabled(true)
                        Text("영상 올리기").font(.large_title)
                            .opacity(0.4)
                            .disabled(true)
                    }
                    else{
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Image("ArrowLeft").foregroundColor(Color(named: "TextMasterColor"))
                                .padding(.leading, 10).padding(.trailing, 6)
                        }
                        Text("영상 올리기").font(.large_title)
                    }
                    Spacer()
                    if(movieURL != nil && movieFileName != nil && title != "" && description != "" && !uploadViewModel.uploadingNow){
                        Button(action: {
                            uploadViewModel.uploadVideo(videoUrl: movieURL!, filename: movieFileName!, title: title, description: description, difficulty: difficulty, angle: angle)
                        }){
                            Image("Pencil")
                                .foregroundColor(.white)
                                .frame(width: 48, height: 48)
                                .background(Color(named:"AccentMasterColor"))
                                .cornerRadius(40)
                                .shadow(color: Color(named:"AccentMasterColor").opacity(0.4), radius: 10)
                        }
                    }
                    else{
                        Image("Pencil")
                            .foregroundColor(.white)
                            .frame(width: 48, height: 48)
                            .background(Color(named:"AccentMasterColor"))
                            .cornerRadius(40)
                            .shadow(color: Color(named:"AccentMasterColor").opacity(0.4), radius: 10)
                            .opacity(0.4)
                    }
                }.padding(.leading, 30).padding(.top, 24).padding(.trailing, 20)
                
                //video area
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
                            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .videos, preferredItemEncoding: .current){
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
                            GeometryReader{geometry in
                                ZStack{
                                    LoadAnimationView(alwaysDark: false)
                                        .frame(width: max(geometry.size.height/4, 100), height: max(geometry.size.width/4, 100))
                                    
                                    
                                    VStack{
                                        VideoPlayer(player: avPlayer)
                                            .frame(width: min(geometry.size.height / videoSize.height * videoSize.width, geometry.size.width), height: min(geometry.size.width / videoSize.width * videoSize.height, geometry.size.height))
                                            .clipped()
                                            .cornerRadius(20)
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                                    
                                }
                                .contentShape(Rectangle())
                            }
                        }
                        
                        Spacer().frame(width: 40)
                    }
                }
                .padding(.top, 20)
                .onChange(of: selectedItems) { newValue in
                    guard let item = selectedItems.first else { return }
                    item.loadTransferable(type: Movie.self) { result in
                        switch result {
                        case .success(let movie):
                            if let movie = movie {
                                avPlayer = AVPlayer(url: movie.url)
                                avPlayer!.playImmediately(atRate: 1.0)
                                
                                movieURL = movie.url
                                movieFileName = movie.url.lastPathComponent
                                
                                let videoAssetSource = AVAsset.init(url: movie.url)
                                videoSize.width = abs(videoAssetSource.videoSize!.width)
                                videoSize.height = abs(videoAssetSource.videoSize!.height)
                                zoomFactor = Float(UIScreen.main.bounds.size.height / videoSize.height)
                            } else {
                                print("movie is nil")
                            }
                        case .failure(let failure):
                            fatalError("\(failure)")
                        }
                    }
                }
                
                //input area
                if(uploadViewModel.uploadingNow){
                    HStack(spacing: 15){
                        Text("제목").font(.textfield_leading)
                        TextField("", text: $title).overlay(VStack{Divider().offset(x: 0, y: 15)})
                    }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
                        .frame(height: 50)
                        .opacity(0.4)
                        .disabled(true)
                    HStack(spacing: 15){
                        Text("설명").font(.textfield_leading)
                        TextField("", text: $description).overlay(VStack{Divider().offset(x: 0, y: 15)})
                    }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
                        .frame(height: 50)
                        .opacity(0.4)
                        .disabled(true)
                    HStack(spacing: 20){
                        Text("각도").font(.textfield_leading)
                        Picker("Angle", selection: $angle){
                            ForEach(angles, id: \.self){
                                Text("\($0)º ")
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .pickerStyle(.menu)
                        .tint(Color(named: "TextMasterColor"))
                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                        
                        Text("난이도").font(.textfield_leading)
                            .padding(.leading, 5)
                        Picker("Difficulty", selection: $difficulty){
                            ForEach(difficulties, id: \.self){
                                Text("V\($0) ")
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .pickerStyle(.menu)
                        .tint(Color(named: "TextMasterColor"))
                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                    .frame(height: 50)
                    .opacity(0.4)
                    .disabled(true)
                }
                else{
                    HStack(spacing: 15){
                        Text("제목").font(.textfield_leading)
                        TextField("", text: $title).overlay(VStack{Divider().offset(x: 0, y: 15)})
                    }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
                        .frame(height: 50)
                    HStack(spacing: 15){
                        Text("설명").font(.textfield_leading)
                        TextField("", text: $description).overlay(VStack{Divider().offset(x: 0, y: 15)})
                    }.padding(.top, 30).padding(.leading, 30).padding(.trailing, 30)
                        .frame(height: 50)
                    HStack(spacing: 20){
                        Text("각도").font(.textfield_leading)
                        Picker("Angle", selection: $angle){
                            ForEach(angles, id: \.self){
                                Text("\($0)º ")
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .pickerStyle(.menu)
                        .tint(Color(named: "TextMasterColor"))
                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                        
                        Text("난이도").font(.textfield_leading)
                            .padding(.leading, 5)
                        Picker("Difficulty", selection: $difficulty){
                            ForEach(difficulties, id: \.self){
                                Text("V\($0) ")
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .pickerStyle(.menu)
                        .tint(Color(named: "TextMasterColor"))
                        .overlay(VStack{Divider().offset(x: 0, y: 15)})
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                    .frame(height: 50)
                }
                
                
                Spacer()
            }
            .padding(.bottom, 20)
            .background(.white.opacity(0))
            .interactiveDismissDisabled(uploadViewModel.uploadingNow)
            
        }
        .background(Color(named: "BackgroundMasterColor"))
        .onReceive(uploadViewModel.viewDismissalModePublisher) { shouldDismiss in
                    if shouldDismiss {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
    }
}


struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView().environmentObject(UploadViewModel())
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
