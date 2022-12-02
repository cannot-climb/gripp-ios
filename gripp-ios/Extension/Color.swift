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
        return [Color("#ffcc00"), Color("#ffe020"), .black]
    case 5..<10:
        return [Color("#337f74"), Color("#206060"), .white]
    case 10..<15:
        return [Color("#a9ccde"), Color("#c0e0f0"), .black]
    case 15..<18:
        return [Color("#dd07f3"), Color("#b000d0"), .white]
    case 19:
        return [Color("#d0d0ff"), Color("#c0c0d0"), .black]
    default:
        return [Color(named: "TextMasterColor"), Color(named: "TextMasterColor"), Color(named: "BackgroundMasterColor")]
    }
    
}

