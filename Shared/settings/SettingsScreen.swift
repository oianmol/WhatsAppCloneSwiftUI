//
//  SettingsScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI
import KeychainSwift

struct SettingsScreen : View{
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View{
            ScrollView{
                LazyVStack{
                    VStack{
                        Space()
                        Section{
                            SettingsUserHeader()
                        }
                        
                        Space()
                        Section{
                            SettingsFirstBlock()
                        }
                        Space()
                        Section{
                            SettingsSecondBlock()
                        }
                        Space()
                        Section{
                            SettingsThirdBlock()
                        }
                        Space()
                    }.background(colorScheme == .dark ? Constants.darkColor : Color.white)
                }
            }.background(Constants.lightDarkColor(colorScheme: colorScheme))
    }
}

struct Space :View{
    var body: some View{
        VStack{
            
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 40,
                maxHeight: .infinity,
                alignment: .topLeading
        ).background(Color.gray.opacity(0.2))
    }
}


public extension View {
    func widthHeightmatchParent() -> some View {
        self.frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .topLeading
        )
    }
    
    func widthMatchParent() -> some View {
        self.frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
}
