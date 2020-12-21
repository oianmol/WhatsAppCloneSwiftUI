//
//  SettingsScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct SettingsScreen : View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        NavigationView{
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
            }.navigationBarItems(leading: Button("Privacy"){
                
            },trailing:Button(action: {}){
                
            }).navigationTitle("Settings")
        }
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
