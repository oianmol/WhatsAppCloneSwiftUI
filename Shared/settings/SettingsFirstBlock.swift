//
//  SettingsFirstBlock.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI


struct SettingsFirstBlock : View{
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View{
        VStack(alignment:.leading){
            SettingsCommonListItem(imageId: "StarredMessages", text: "Starred Messages",divider: true)
            SettingsCommonListItem(imageId: "WhatsAppWeb", text: "WhatsaApp Web/Desktop",divider: false)
        }.background(colorScheme == .dark ? Color.black: Color.white)
    }
}
