//
//  SettingsSecondBlock.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct SettingsSecondBlock : View{
    var body: some View{
        VStack(alignment:.leading){
            SettingsCommonListItem(imageId: "AccountIcon", text: "Account")
            SettingsCommonListItem(imageId: "Chats", text: "Chats")
            SettingsCommonListItem(imageId: "Notifications", text: "Notifications")
            SettingsCommonListItem(imageId: "DataStorage", text: "Data and Storage Usage")
        }.background(Color.white)
    }
}
