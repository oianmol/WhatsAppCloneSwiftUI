//
//  SettingsScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct SettingsScreen : View{
    var body: some View{
        NavigationView{
            ScrollView{
                VStack{
                    Spacer(minLength: 40)
                    SettingsUserHeader()
                    Spacer(minLength: 40)
                    SettingsFirstBlock()
                    Spacer(minLength: 40)
                    SettingsSecondBlock()
                    Spacer(minLength: 40)
                    SettingsThirdBlock()
                    Spacer(minLength: 40)
                }.widthHeightmatchParent()
            }.background(Color.gray.opacity(0.2))
            .navigationTitle("Settings")
            .navigationBarItems(leading: Button("Privacy"){
                
            })
        }
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
