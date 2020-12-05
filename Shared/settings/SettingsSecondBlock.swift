//
//  SettingsSecondBlock.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct SettingsSecondBlock : View{
    @Environment(\.colorScheme) var colorScheme

    var body: some View{
        VStack(alignment:.leading){
            SettingsCommonListItem(imageId: "AccountIcon", text: "Account",divider: true)
            SettingsCommonListItem(imageId: "Chats", text: "Chats",divider: true)
            SettingsCommonListItem(imageId: "Notifications", text: "Notifications",divider: true)
            SettingsCommonListItem(imageId: "DataStorage", text: "Data and Storage Usage",divider: false)
        }.background(colorScheme == .dark ? Color.black: Color.white)
    }
}
