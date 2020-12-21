//
//  Constants.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 06/12/20.
//

import Foundation
import SwiftUI


#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


public struct Constants{
    static let darkColor = Color.init(red: 23 / 255, green: 34 / 255, blue: 44 / 255)
    static let IS_AUTH = "is_authorized"
    
    static func lightDarkColor(colorScheme:ColorScheme) -> Color{
        colorScheme == .light ? Color.white : Constants.darkColor
    }
    
}

extension Color {
    func toUiColor() -> UIColor {
        return  UIColor.init(self)
    }
}
