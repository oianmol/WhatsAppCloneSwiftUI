//
//  WhatsAppCloneApp.swift
//  Shared
//
//  Created by Anmol Verma on 05/12/20.
//

import SwiftUI
import KeychainSwift

@main
struct WhatsAppCloneApp: App {
   @ObservedObject var authStore = AuthServiceStore()

    var body: some Scene {
        WindowGroup {
            if(authStore.isLoggedIn()){
                HomeScreen().environmentObject(authStore)
            }else{
                PhoneAuthScreen().environmentObject(authStore)
            }
        }
    }
}
