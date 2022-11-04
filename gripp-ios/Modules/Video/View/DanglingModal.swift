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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isExpanded: Bool
    @State private var isDragging: Bool = false
    @State private var currHeight: CGFloat = 0
    @State var minHeight: CGFloat = 0
    @State var maxHeight: CGFloat = 10
    
    @State var avPlayer:AVPlayer?
    @State var videoPlaying: Bool = true
    
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
                    .frame (width: UIScreen.main.bounds.width, height: currHeight)
                    .transition (.move(edge: .bottom))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation (.easeInOut(duration: 0.1))
            .gesture(dragGesture)
            .onAppear(){
                minHeight = geometry.size.height - geometry.size.width/9*16
                currHeight = minHeight
                isExpanded = false
                maxHeight = geometry.size.height - 30
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
                
                Text("Video Title").font(.large_title)
                    .padding(.top, 5).padding(.bottom, 18)
                Spacer()
                    .contentShape(Rectangle())
                Button(action: {
                    avPlayer!.seek(to: .zero)
                }){
                    Image("Refresh")
                        .padding(.horizontal, 10)
                        .padding(.top, 5)
                        .padding(.bottom, 18)
                        .contentShape(Rectangle())
                }
                Button(action: {
                    if(avPlayer!.timeControlStatus == AVPlayer.TimeControlStatus.playing){
                        avPlayer!.pause()
                        videoPlaying = false
                    }
                    else{
                        avPlayer!.play()
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
//                if(avPlayer!.isPlaying){
//                    Button(action: {
//                        avPlayer?.pause()
//                    }){
//                        Image("Pause")
//                            .padding(.horizontal, 30)
//                            .padding(.top, 5)
//                            .padding(.bottom, 18)
//                            .contentShape(Rectangle())
//                    }
//                }
//                else{
//                    Button(action: {
//                        avPlayer?.play()
//                    }){
//                        Image("Play")
//                            .padding(.horizontal, 30)
//                            .padding(.top, 5)
//                            .padding(.bottom, 18)
//                            .contentShape(Rectangle())
//                    }
//                }
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
                        Button(action: {}){
                            HStack{
                                Text("18")
                                    .font(.foot_note)
                                    .padding(.trailing, 4)
                                Image("HeartOutlined")
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(.white)
                            .cornerRadius(100)
                            .padding(.trailing, 24)
                            .padding(.top, 24)
                            .shadow(color: .black.opacity(0.2), radius: 10)
                        }.foregroundColor(.black)
                    }
                    Spacer()
                }
                
                VStack(spacing: 16){
                    Capsule()
                        .frame(width: 50, height: 7)
                        .opacity(0.6)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            isExpanded.toggle()
                            if(isExpanded){
                                currHeight = maxHeight
                            }
                            else{
                                currHeight = minHeight
                            }
                        }
                    
                    ModalInfoLine(imageString: "Angle", text: "45º / V3")
                        .padding(.top, 4)
                    ModalInfoLine(imageString: "Calendar", text: "2022/09/12")
                    HStack(alignment: .top){
                        Spacer()
                            .frame(width: 40)
                        Image("Person")
                            .padding(.trailing, 8)
                        NavigationLink(destination: GalleryView(contextString: "", shouldHaveChin: false).navigationBarBackButtonHidden(true)) {
                            Text("UserName").font(.player_id)
                                .padding(.top,3)
                                .foregroundColor(Color(named:"AccentMasterColor")).padding(.bottom, 1)
                        }
                        Spacer()
                    }.frame(height: 30)
                    ModalInfoLine(imageString: "Eye", text: "103회")
                    ModalInfoLine(imageString: "Description", text: "Lorem ipsum dolor sit amet, consectetur adipiscin.")
                    
                    Button(action: {}){
                        Image("Trash")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            .background(Color("#FF4B4B"))
                            .cornerRadius(100)
                            .padding(.top, 30)
                    }
                    .foregroundColor(.black)
                    .padding(.bottom, 80)
                    .shadow(color: .red.opacity(0.4), radius: 10)
                    
//                    ModalInfoLine(imageString: "Eye", text: "\(minHeight) / \(maxHeight)")
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: .infinity)
            .background(.thinMaterial)
            .cornerRadius(24, corners: [.topLeft, .topRight])
        }
        .frame(width: UIScreen.main.bounds.width)
        .animation(isDragging ? nil : .easeInOut(duration: 0.2))
        .offset(y: 100)
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
                print(currHeight)
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

struct DanglingModal_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Image(uiImage: UIImage(named: "img1.jpg" ?? "") ?? UIImage())
            DanglingModal(isExpanded: .constant(false))
        }
    }
}
