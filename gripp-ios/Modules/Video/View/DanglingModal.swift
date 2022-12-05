//
//  ActionSheet.swift
//  gripp-ios
//
//  https://www.youtube.com/watch?v=I1fsl1wvsjY
//
//  Created by 조준오 on 2022/11/04.
//

import SwiftUI
import AVKit

struct DanglingModal: View {
    
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isExpanded: Bool
    @State private var isDragging: Bool = false
    @State private var currHeight: CGFloat = -300
    @State var minHeight: CGFloat = 0
    @State var maxHeight: CGFloat = 10
    @State var shouldShowDeleteDialog = false
    
    @Binding var avPlayer:AVPlayer
    @State var videoPlaying: Bool = true
    
    @StateObject var galleryViewModel = GalleryViewModel()
    
    public var removeAction: ()->()
    
    var dragPercentage: Double {
        let res = Double ((currHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    
    var body: some View {
        GeometryReader{geometry in
            ZStack(alignment: .bottom) {
                if(isExpanded){
                    Color.black
                        .opacity(dragPercentage*0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            currHeight = minHeight
                            isExpanded = false
                        }
                        .contentShape(Rectangle())
                        .allowsHitTesting(false)
                }
                content
                    .transition (.move(edge: .bottom))
                    .offset(y: geometry.size.height - currHeight - 50 - 24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.2))
            .gesture(dragGesture)
            .onAppear(){
                minHeight = DOCK_HEIGHT
                currHeight = minHeight
                isExpanded = false
                maxHeight = UIScreen.main.bounds.height-160
                
                galleryViewModel.username = playerViewModel.videoUser
            }
        }
    }
    
    var content: some View{
        VStack(spacing: 0){
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image("ArrowLeft")
                        .contentShape(Rectangle())
                        .padding(.leading, 30)
                        .padding(.trailing, 6)
                        .padding(.top, 5)
                        .padding(.bottom, 18)
                }
                
                Text(playerViewModel.videoTitle).font(.large_title)
                    .padding(.top, 5).padding(.bottom, 18)
                Spacer()
                    .contentShape(Rectangle())
                Button(action: {
                    avPlayer.seek(to: .zero)
                    avPlayer.playImmediately(atRate: 1.0)
                    videoPlaying = true
                }){
                    Image("Refresh")
                        .padding(.horizontal, 10)
                        .padding(.top, 5)
                        .padding(.bottom, 18)
                        .contentShape(Rectangle())
                }
                Button(action: {
                    if(avPlayer.timeControlStatus == AVPlayer.TimeControlStatus.playing){
                        avPlayer.pause()
                        videoPlaying = false
                    }
                    else{
                        avPlayer.play()
                        videoPlaying = true
                    }
                }){
                    if(videoPlaying){
                        Image("Pause")
                            .padding(.trailing, 30)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                            .padding(.bottom, 18)
                            .contentShape(Rectangle())
                    }
                    else{
                        Image("Play")
                            .padding(.trailing, 30)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                            .padding(.bottom, 18)
                            .contentShape(Rectangle())
                    }
                }
            }
            .foregroundColor(.white)
            .contentShape(Rectangle())
            .shadow(color: .black.opacity(0.4), radius: 10)
            .shadow(color: .black.opacity(0.6), radius: 30)
            .shadow(color: .black.opacity(0.6), radius: 40)
            .shadow(color: .black.opacity(1), radius: 50)
            
            ZStack(alignment: .top){
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            impactSoft.impactOccurred()
                            playerViewModel.toggleFavorite()
                        }){
                            if(playerViewModel.videoFavorite){
                                HStack{
                                    Text(playerViewModel.videoFavoriteCount)
                                        .font(.foot_note)
                                        .padding(.trailing, 4)
                                    Image("HeartOutlined")
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(.red)
                                .foregroundColor(Color(named: "TextMasterColor"))
                                .cornerRadius(100)
                                .padding(.trailing, 24)
                                .padding(.top, 24)
                                .shadow(color: .black.opacity(0.2), radius: 10)
                            }
                            else{
                                HStack{
                                    Text(playerViewModel.videoFavoriteCount)
                                        .font(.foot_note)
                                        .padding(.trailing, 4)
                                    Image("HeartOutlined")
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(.white)
                                .foregroundColor(.black)
                                .cornerRadius(100)
                                .padding(.trailing, 24)
                                .padding(.top, 24)
                                .shadow(color: .black.opacity(0.2), radius: 10)
                            }
                        }
                    }
                    Spacer()
                }
                
                VStack(spacing: 16){
                    Capsule()
                        .frame(width: 50, height: 6)
                        .opacity(0.5)
                        .padding(.vertical, 10)
                    
                    ModalInfoLine(imageString: "Fire", pre:"V", text: $playerViewModel.videoLevel)
                    ModalInfoLine(imageString: "Angle", text: $playerViewModel.videoAngle, post: "º")
                        .padding(.top, 4)
                    ModalInfoLine(imageString: "Calendar", text: $playerViewModel.videoDate)
                    HStack(alignment: .top){
                        Spacer()
                            .frame(width: 40)
                        Image("Person")
                            .padding(.trailing, 8)
                        NavigationLink(destination: GalleryView(contextString: "", shouldHaveChin: false).environmentObject(galleryViewModel).navigationBarBackButtonHidden(true)) {
                            Text(playerViewModel.videoUser).font(.player_id)
                                .padding(.top,3)
                                .foregroundColor(Color(named:"AccentMasterColor")).padding(.bottom, 1)
                        }
                        Spacer()
                    }.frame(height: 30)
                    ModalInfoLine(imageString: "Eye", text: $playerViewModel.videoViewCount, post: "회")
                    ModalInfoLine(imageString: "Description", text: $playerViewModel.videoDescription)
                    
                    if(playerViewModel.videoUser == getUserName()!){
                        Button(action: {
                            shouldShowDeleteDialog.toggle()
                        }){
                            HStack(spacing: 20){
                                Text("삭제").font(.player_id)
                                Image("Trash")
                            }
                            .padding(.horizontal, 35)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(Color("#D02010"))
                            .cornerRadius(100)
                            .padding(.top, 30)
                        }
                        .foregroundColor(.black)
                        .padding(.bottom, 80)
                        .shadow(color: .red.opacity(0.2), radius: 10)
                        .confirmationDialog("정말 삭제할까요?",isPresented: $shouldShowDeleteDialog, titleVisibility: .visible){
                            Button("삭제", role: .destructive) {
                                playerViewModel.deleteVideo()
                            }
                            Button("취소", role: .cancel) {
                                
                            }
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color(named: "BackgroundMasterColor").opacity(0.3))
            .background(.thinMaterial)
            .cornerRadius(24, corners: [.topLeft, .topRight])
        }
        .frame(width: UIScreen.main.bounds.width)
        .animation(isDragging ? nil : .easeInOut(duration: 0.2))
        .onReceive(playerViewModel.deleteSuccessPublisher, perform: {
            impactRigid.impactOccurred()
            removeAction()
            presentationMode.wrappedValue.dismiss()
        })
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged{ val in
                if(!isDragging){
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if (currHeight > maxHeight || currHeight < minHeight){
                    currHeight -= dragAmount / 6
                } else {
                    currHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded{ val in
                prevDragTranslation = .zero
                isDragging = false
                if(!isExpanded){
                    if currHeight > (maxHeight+minHeight)/8{
                        currHeight = maxHeight
                        isExpanded = true
                    }
                    else {
                        currHeight = minHeight
                        isExpanded = false
                    }
                }
                else{
                    if currHeight > (maxHeight+minHeight)*7/8{
                        currHeight = maxHeight
                        isExpanded = true
                    }
                    else {
                        currHeight = minHeight
                        isExpanded = false
                    }
                }
            }
    }
}
