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
    
    static func lightDarkTextColor(colorScheme:ColorScheme) -> Color{
        colorScheme == .dark ? Color.white : Constants.darkColor
    }
    
}

extension Color {
    func toUiColor() -> UIColor {

         if #available(iOS 14.0, *) {
             return UIColor(self)
         }

         let components = self.components()
         return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
     }

     private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

         let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
         var hexNumber: UInt64 = 0
         var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

         let result = scanner.scanHexInt64(&hexNumber)
         if result {
             r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
             g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
             b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
             a = CGFloat(hexNumber & 0x000000ff) / 255
         }
         return (r, g, b, a)
     }
}
