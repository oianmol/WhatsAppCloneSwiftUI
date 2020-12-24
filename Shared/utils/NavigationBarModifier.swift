//
//  NavigationBarModifier.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 24/12/20.
//

import Foundation
import SwiftUI
import UIKit

class ChatterNavigationAppearance {
    
    static func procesColors(current:UITraitCollection?){
        let titleColor = current?.userInterfaceStyle == .light ? Constants.darkColor.toUiColor() :.white
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = current?.userInterfaceStyle == .dark ? Constants.darkColor.toUiColor() :.white
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    static func processColors(colorScheme:ColorScheme){
        let titleColor = Constants.lightDarkTextColor(colorScheme: colorScheme).toUiColor()
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = Constants.lightDarkColor(colorScheme: colorScheme).toUiColor()
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    
}

struct NavigationBarModifier: ViewModifier {


    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(Constants.lightDarkColor(colorScheme: colorScheme).toUiColor())
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }.onAppear{
            ChatterNavigationAppearance.processColors(colorScheme:colorScheme)
        }
    }
}

extension View {

    func navigationBarChatterColor() -> some View {
        self.modifier(NavigationBarModifier())
    }

}
