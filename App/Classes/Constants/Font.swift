//
//  Font.swift
//  iOS Starter Project
//
//  Created by Halcyon Mobile on 18/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    /// 9
    case extraSmall     = 7
    /// 11
    case small          = 11
    /// 14
    case mediumSmall    = 14
    /// 16
    case medium         = 16
    /// 18
    case mediumLarge    = 18
    /// 24
    case large          = 24
    /// 32
    case extraLarge     = 32
}

private struct FontFamily {
    
    enum Lato: String, FontConvertible {
        case light            = "Lato-Light"
        case regular          = "Lato-Medium"
        case bold             = "Lato-Bold"
    }
}

struct Font {
    
    static func light(size: FontSize) -> UIFont {
        return FontFamily.Lato.light.font(size: size)
    }
    
    static func regular(size: FontSize) -> UIFont {
        return FontFamily.Lato.regular.font(size: size)
    }
    
    static func bold(size: FontSize) -> UIFont {
        return FontFamily.Lato.bold.font(size: size)
    }
}

protocol FontConvertible {
    func font(size: FontSize) -> UIFont!
}

extension FontConvertible where Self: RawRepresentable, Self.RawValue == String {
    
    func font(size: FontSize) -> UIFont! {
        return UIFont(name: self.rawValue, size: size.rawValue)
    }
}
