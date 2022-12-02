//
//  Roboto.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/04.
//

import Foundation
import SwiftUI

extension Font {
    
    /// Create a font with the large title text style.
    public static var large_title: Font {
        return Font.custom("Roboto-Bold", size: 24)
    }
    
    /// Create a font with the title text style.
    public static var title: Font {
        return Font.custom("Roboto-Bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    /// Create a font with the headline text style.
    public static var head_line: Font {
        return Font.custom("Roboto-Regular", size: 18)
    }
    
    /// Create a font with the subheadline text style.
    public static var sub_head_line: Font {
        return Font.custom("Roboto-Regular", size: 14)
    }
    
    /// Create a font with the body text style.
    public static var body: Font {
        return Font.custom("Roboto-Bold", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    /// Create a font with the callout text style.
    public static var callout: Font {
        return Font.custom("Roboto-Bold", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
    }
    
    /// Create a font with the footnote text style.
    public static var foot_note: Font {
        return Font.custom("Roboto-Regular", size: 14)
    }
    
    /// Create a font with the caption text style.
    public static var context: Font {
        return Font.custom("Roboto-Bold", size: 14)
    }
    
    
    public static var textfield_leading: Font {
        return Font.custom("Roboto-Bold", size: 18)
    }
    
    public static var podium_id: Font {
        return Font.custom("Roboto-Regular", size: 16)
    }
    public static var podium_level: Font {
        return Font.custom("Roboto-Regular", size: 15)
    }
    public static var podium_footer: Font {
        return Font.custom("Roboto-Regular", size: 14)
    }
    
    
    
    public static var player_tier_pill: Font {
        return Font.custom("Roboto-Bold", size: 10)
    }
    public static var player_id: Font {
        return Font.custom("Roboto-Bold", size: 16)
    }
    public static var player_id_info: Font {
        return Font.custom("Roboto-Bold", size: 16)
    }
    public static var player_vid_info: Font {
        return Font.custom("Roboto-Regular", size: 16)
    }
    public static var player_vid_description: Font {
        return Font.custom("Roboto-Regular", size: 13)
    }
    
    
    public static var login_button: Font {
        return Font.custom("Roboto-Bold", size: 14)
    }
    public static var login_textfield: Font {
        return Font.custom("Roboto-Bold", size: 13)
    }
    
    public static var tabbar_item: Font {
        return Font.custom("Roboto-Light", size: 10)
    }
    
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "Roboto-Bold"
        switch weight {
        case .bold: font = "Roboto-Bold"
        case .heavy: font = "Roboto-ExtraBold"
        case .light: font = "Roboto-Light"
        case .medium: font = "Roboto-Regular"
        case .semibold: font = "Roboto-SemiBold"
        case .thin: font = "Roboto-Light"
        case .ultraLight: font = "Roboto-Light"
        default: break
        }
        return Font.custom(font, size: size)
    }
}
