//
//  LoadAnimationView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/28.
//

import SwiftUI

struct LoadAnimationView: View {
    @State var animate = true
    var color = Color(.black)
    
    init(alwaysDark: Bool){
        if(alwaysDark){
            color = .white
        }
        else{
            color = Color(named: "TextMasterColor")
        }
    }
    
    
    var body: some View{
        GeometryReader{gr in
            let zoomFactor = min(gr.size.width, gr.size.height)
            ZStack(alignment: .center){
                Circle()
                    .stroke(AngularGradient (gradient: .init (colors: [color]), center: .center), style: StrokeStyle(lineWidth: zoomFactor/18, lineCap: .round))
                
                Circle()
                    .trim(from: 0.1, to: 0.101)
                    .stroke(AngularGradient (gradient:.init (colors: [color]), center: .center), style: StrokeStyle(lineWidth: zoomFactor/5, lineCap: .round))
                    .shadow(color: color, radius: zoomFactor/20)
                    .rotationEffect(Angle(degrees: animate ? 0: 360))
                    .animation(Animation.linear (duration: 1.3).repeatForever(autoreverses: false), value: animate)
                    .onAppear{animate = false}
                    .onDisappear{animate = false}
            }
            .padding(zoomFactor/6)
            .frame(width: gr.size.width, height: gr.size.height)
        }
    }
}


struct LoadAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadAnimationView(alwaysDark: false)
            .frame(width: 400, height: 300)
            .background(Color(named: "BackgroundSubduedColor"))
    }
}
