//
//  HomeScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct HomeScreen : View{
    @State private var selected = 0

    var body: some View{
        TabView(selection: $selected){
            Text("Status").tabItem {
                Image(self.selected == 0 ? "StatusSelected":"StatusNormal")
                Text("Status")
            }.tag(0)
            
            Text("Calls").tabItem {
                Image(systemName:self.selected == 1 ? "phone.fill":"phone")
                Text("Calls")
            }.tag(1)
            
            WHCameraView().tabItem {
                Image(systemName:self.selected == 2 ? "camera.fill":"camera")
                Text("Camera")
            }.tag(2)
            
            ChatsScreen().tabItem {
                Image(systemName:self.selected == 3 ? "message.fill":"message")
                Text("Chats")
            }.tag(3)
            
            SettingsScreen().tabItem {
                Image(self.selected == 4 ? "settings.selected":"settings.normal")
                Text("Settings")
            }.tag(4)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
