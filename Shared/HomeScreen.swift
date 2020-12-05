//
//  HomeScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct HomeScreen : View{
    @State private var selected = 3
    
    var body: some View {
        let view = NavigationTabs(selected: self.$selected)
        NavigationView{
            if(selected == 3){
           
                    view.navigationBarItems(leading: Button("Edit"){
                        
                    },trailing: Button(action:{}){
                        Image(systemName: "pencil")
                    })
                   
                
              
            }else if(selected == 4){
                view
                   .navigationBarItems(leading: Button("Privacy"){
                       
                   },trailing:Button(action: {}){
                       
                   })
            }else{
                view
            }
        }
        
        
    }
    
    
}

struct NavigationTabs:View{
    @Binding var selected : Int
    
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
        }.navigationTitle(getNavigationTitle())
        
    }
    
    func getNavigationTitle() -> String{
        switch selected {
        case 0:
            return "Status";
        case 1:
            return "Calls";
        case 2:
            return "Camera"
        case 3:
            return "Chats";
        case 4:
            return "Settings"
        default:
            return "Tag";
        }
    }
}

extension View{
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
