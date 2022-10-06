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
        colorString = colorString.replacingOccurrences(of: "#", with: "")
        let rangeFirstIndex = colorString.index(after: colorString.startIndex)
        let rangeStartIndex = colorString.index(rangeFirstIndex, offsetBy: 1)
        let rangeEndIndex = colorString.index(rangeFirstIndex, offsetBy: 2)
        let r = colorString.prefix(2)
        let g = colorString[rangeStartIndex...rangeEndIndex]
        let b = colorString.suffix(2)
        
        self = Color(UIColor(
            red: CGFloat(UInt8(r, radix: 16)!) / 255.0,
            green: CGFloat(UInt8(g, radix: 16)!) / 255.0,
            blue: CGFloat(UInt8(b, radix: 16)!) / 255.0,
            alpha: CGFloat(1.0)
        ))
        
    }
}
