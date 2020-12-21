//
//  SettingsThirdBlock.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI
import KeychainSwift

struct SettingsThirdBlock : View{
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authStore: AuthServiceStore

    var body: some View{
        VStack(alignment:.leading){
            SettingsCommonListItem(imageId: "Help", text: "Help",divider: true)
            Button(action: {
                authStore.logOut()
            }, label: {
                SettingsCommonListItem(imageId: "TellFriend", text: "Tell a Friend",divider: false)
            })
        }.background(colorScheme == .dark ? Constants.darkColor: Color.white)
    }
}
