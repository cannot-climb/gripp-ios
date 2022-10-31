//
//  LoadAnimationView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/28.
//

import SwiftUI

struct LoadAnimationView: View {
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    @State var animate = true
    let color = Color.white
    var body: some View{
        ZStack{
            Circle()
                .stroke(AngularGradient (gradient: .init (colors: [color]), center: .center), style: style)
            
            Circle()
                .trim(from: 0.1, to: 0.101)
                .stroke(AngularGradient (gradient:.init (colors: [color]), center: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .shadow(color: .white, radius: 10)
                .rotationEffect(Angle(degrees: animate ? 0: 360))
                .animation(Animation.linear (duration: 0.9).repeatForever(autoreverses: false), value: animate)
                .onAppear{animate = false}
                .onDisappear{animate = falsLe}
        }
    }
}


struct LoadAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadAnimationView()
            .frame(width: 100, height: 100)
            .padding(.all, 20)
            .background(.black)
    }
}
