//
//  HomeView.swift
//  gripp-ios
//
//  https://stackoverflow.com/questions/67616887/how-to-align-swiftui-menu-item-with-checkmark-in-macos
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI
import RangeSeekSlider

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let shouldHaveChin : Bool
    @StateObject var viewRouter: ViewRouter
    @State var showSlider = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Gripp").font(.context)
                .padding(.leading, 31).padding(.top, 6)
                .foregroundColor(Color(named: "TextSubduedColor"))
            Button(action:{
                withAnimation(.easeInOut(duration: 0.25)){
                    viewRouter.currentPage = .myGallery
                }
            }){
                Text(homeViewModel.titleUserName).font(.large_title)
                Image("ArrowRight")
            }.padding(.leading, 30).padding(.top, 5)
                .foregroundColor(Color(named: "TextMasterColor"))
            HStack(alignment: .center){
                Text(homeViewModel.titleUserInfoString).font(.foot_note)
                    .padding(.leading, 32)
                
                Spacer()
                
                Button(action:{
                    withAnimation {
                        showSlider.toggle()
                    }
                }){
                    Text("난이도").font(.foot_note)
                        .foregroundColor(Color(named: "TextMasterColor"))
                    Image("ArrowRight")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .rotationEffect(Angle(degrees: showSlider ? 270 : 90))
                        .padding(.trailing, 32)
                        .foregroundColor(Color(named: "TextMasterColor"))
                }
                
            }.padding(.top, 4).padding(.bottom, 16)
            
            
            ZStack(alignment: .topTrailing){
                RangeSeekSliderWrapper(homeViewModel: homeViewModel)
                    .shadow(color: .black.opacity(0.3),radius: 10, y: 3)
                    .padding(.bottom,20)
                    .padding(.horizontal, 20)
                    .background(Color(named: "TextMasterColor").opacity(0.05))
                    .frame(height: 100)
                    .cornerRadius(20)
                    .contentShape(Rectangle())
                    .padding(.top,5)
                    .padding(.horizontal, 14)
                    .shadow(color: .black.opacity(0.05),radius: 1, y: 3)
                    .opacity(showSlider ? 100 : 0)
                
                ImageGrid(postItemImages: homeViewModel.articles, firstItemGiantDecoration: true,noMoreData: $homeViewModel.noMoreData, shouldHaveChin: shouldHaveChin, refreshAction: homeViewModel.refresh, moreAction: homeViewModel.loadVideoList)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                    .shadow(color: Color(named:"ShadowSheetColor"), radius: 20)
                    .padding(.top, showSlider ? 130 : 0)
            }
            
        }
        .background(Color(named:"BackgroundSubduedColor"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(shouldHaveChin: false, viewRouter: ViewRouter()).environmentObject(HomeViewModel())
    }
}


struct RangeSeekSliderWrapper: UIViewRepresentable {
    typealias UIViewType = UIView
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    func makeUIView(context: Context) -> UIViewType {
        let view = CustomRangeSeekSlider()
        
        view.selectedMinValue = CGFloat(homeViewModel.minLevel)
        view.selectedMaxValue = CGFloat(homeViewModel.maxLevel)
        view.delegate = context.coordinator
        
        return view
    }
    
     func makeCoordinator() -> Coordinator {
         return Coordinator(self)
     }
    
    class Coordinator: NSObject, RangeSeekSliderDelegate {
        var parent: RangeSeekSliderWrapper
        
        init(_ parent: RangeSeekSliderWrapper){
            self.parent = parent
        }
        
        func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
            parent.homeViewModel.minLevel = Int(minValue)
            parent.homeViewModel.maxLevel = Int(maxValue)
        }
        func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
            return "V\(Int(minValue))"
        }

        func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
            return "V\(Int(maxValue))"
        }

        func didEndTouches(in slider: RangeSeekSlider) {
            parent.homeViewModel.refresh()
        }
    }
       
    
    func updateUIView(_ view: UIViewType, context: Context) {
        
    }
}
