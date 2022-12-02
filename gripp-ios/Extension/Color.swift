//
//  Color.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/09/20.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    
    static var backgroundColor: Color {
        return self.init("background_color")
    }
    
    static var lightBackgroundColor: Color {
        return self.init("light_background_color")
    }
    
    static var labelColor: Color {
        return self.init("label_color")
    }
    
    static var shadowColor: Color {
        return self.init("shadowColor")
    }
    
    init (named: String) {
        self.init(UIColor(named: named) ?? .clear)
    }
}

extension Color{
    init(_ hex: String){
        var colorString = hex
        let result = colorString.range(of: #"[0-9,A-F,a-f]{6}"#,
                         options: .regularExpression) != nil
        if(result){
            colorString = colorString.replacingOccurrences(of: "#", with: "")
            let rangeFirstIndex = colorString.index(after: colorString.startIndex)
            let rangeStartIndex = colorString.index(rangeFirstIndex, offsetBy: 1)
            let rangeEndIndex = colorString.index(rangeFirstIndex, offsetBy: 2)
            let r = colorString.prefix(2)
            let g = colorString[rangeStartIndex...rangeEndIndex]
            let b = colorString.suffix(2)
            
            
            self = Color(UIColor(
                red: CGFloat(UInt8(r, radix: 16) ?? 0) / 255.0,
                green: CGFloat(UInt8(g, radix: 16) ?? 0) / 255.0,
                blue: CGFloat(UInt8(b, radix: 16) ?? 0) / 255.0,
                alpha: CGFloat(1.0)
            ))
        }
        else{
            self = Color(.black)
        }
    }
}


func getGradient(color1:Color,color2:Color) -> LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [color1, color2]),
                             startPoint: .leading, endPoint: .trailing)
}




func tierColorProvider(_ tier: Int) -> [Color]{
    switch tier {
    case 1..<5:
        return [Color("#0c991e"), Color("#20a040"), .white] // green
    case 5..<10:
        return [Color("#f76806"), Color("#c24e00"), .white] // orange
    case 10..<15:
        return [Color("#333f74"), Color("#205080"), .white] // blue
    case 15..<19:
        return [Color("#d007f3"), Color("#b000d0"), .white] // purple
    case 19:
        return [Color("#d2ac47"), Color("#edc967"), .black] // gold
        
        
    default:
        return [Color(named: "TextMasterColor"), Color(named: "TextMasterColor"), Color(named: "BackgroundMasterColor")]
    }
    
}



struct Color_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            Text("V0").font(.player_tier_pill)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(tierColorProvider(0)[2])
                .background(getGradient(color1: tierColorProvider(0)[0], color2: tierColorProvider(0)[1]))
                .cornerRadius(50, corners: .allCorners)
            Text("V1").font(.player_tier_pill)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(tierColorProvider(1)[2])
                .background(getGradient(color1: tierColorProvider(1)[0], color2: tierColorProvider(1)[1]))
                .cornerRadius(50, corners: .allCorners)
            Text("V5").font(.player_tier_pill)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(tierColorProvider(5)[2])
                .background(getGradient(color1: tierColorProvider(5)[0], color2: tierColorProvider(5)[1]))
                .cornerRadius(50, corners: .allCorners)
            Text("V10").font(.player_tier_pill)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(tierColorProvider(10)[2])
                .background(getGradient(color1: tierColorProvider(10)[0], color2: tierColorProvider(10)[1]))
                .cornerRadius(50, corners: .allCorners)
            Text("V15").font(.player_tier_pill)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(tierColorProvider(15)[2])
                .background(getGradient(color1: tierColorProvider(15)[0], color2: tierColorProvider(15)[1]))
                .cornerRadius(50, corners: .allCorners)
            Text("V19").font(.player_tier_pill)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(tierColorProvider(19)[2])
                .background(getGradient(color1: tierColorProvider(19)[0], color2: tierColorProvider(19)[1]))
                .cornerRadius(50, corners: .allCorners)
        }
    }
}
