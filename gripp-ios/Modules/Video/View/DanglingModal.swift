//
//  ActionSheet.swift
//  gripp-ios
//
//  https://www.youtube.com/watch?v=I1fsl1wvsjY
//
//  Created by 조준오 on 2022/11/04.
//

import SwiftUI

struct DanglingModal: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isExpanded: Bool
    @State private var isDragging: Bool = false
    @State private var currHeight: CGFloat = 600
    @State var minHeight: CGFloat = 0
    @State var maxHeight: CGFloat = 10
    
    var body: some View {
        GeometryReader{geometry in
            VStack {
                Spacer()
                Color.clear
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isExpanded = false
                    }
                content
                    .frame (height: currHeight)
                    .frame (maxWidth: .infinity)
                    .transition (.move(edge: .bottom))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation (.easeInOut(duration: 0.1))
            .gesture(dragGesture)
            .onAppear(){
                minHeight = geometry.size.height - geometry.size.width/9*16
                maxHeight = 600
            }
        }
    }
    
    var content: some View{
        VStack{
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image("ArrowLeft")
                }.padding(.leading, 30)
                    .padding(.trailing, 6)
                
                Text("Video Title").font(.large_title)
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.top, 5).padding(.bottom, 18)
            .shadow(color: .black.opacity(1), radius: 30)
            
            ZStack{
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
                        }.foregroundColor(.black)
                    }
                    Spacer()
                }
                
                VStack(spacing: 16){
                    Capsule()
                        .frame(width: 50, height: 7)
                        .padding(.top, 8)
                    
                    ModalInfoLine(imageString: "Angle", text: "45º / V3")
                        .padding(.top, 10)
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
                    
                    ModalInfoLine(imageString: "Eye", text: "\(minHeight) / \(maxHeight)")
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(.thinMaterial)
            .cornerRadius(24, corners: [.topLeft, .topRight])
        }
        .frame(width: UIScreen.main.bounds.width)
        .animation(isDragging ? nil : .easeInOut(duration: 0.2))
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
                if currHeight > (maxHeight+minHeight)/2 {
                    currHeight = maxHeight
                }
                else if currHeight < (maxHeight+minHeight)/2 {
                    currHeight = minHeight
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
