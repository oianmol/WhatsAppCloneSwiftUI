//
//  SettingsFirstBlock.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI


struct SettingsFirstBlock : View{
    var body: some View{
        VStack(alignment:.leading){
            SettingsCommonListItem(imageId: "StarredMessages", text: "Starred Messages")
            SettingsCommonListItem(imageId: "WhatsAppWeb", text: "WhatsaApp Web/Desktop")
        }.background(Color.white)
    }
}
