//
//  HomeScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct HomeScreen : View{
    
  
    @Environment(\.colorScheme) var colorScheme

    @State private var selected = 3
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var chatsNavTitle = "Chats"
    
    
    
    var body: some View {
        let view = NavigationTabs(selected: self.$selected,searchBar:searchBar)

            if(selected == 2){
                view
            }
            else if(selected == 3){
                NavigationView {
                    view.navigationBarItems(leading: Button("Edit"){

                    },trailing: Button(action:{}){
                        Image(systemName: "pencil")
                    }).navigationTitle(getNavigationTitle()).add(searchBar)
                }

            }else if(selected == 4){
                NavigationView{
                    view
                        .navigationBarItems(leading: Button("Privacy"){

                        },trailing:Button(action: {}){

                        }).navigationTitle(getNavigationTitle())
                }

            }else{
                NavigationView{
                    view.navigationTitle(getNavigationTitle())
                }

            }

        

    }
    
    func getNavigationTitle() -> String{
        switch selected {
        case 0:
            return "Status";
        case 1:
            return "Calls";
        case 2:
            return ""
        case 3:
            return "Chats";
        case 4:
            return "Settings"
        default:
            return "Tag";
        }
    }

    
}

struct NavigationTabs:View{
    @Binding var selected : Int
    @ObservedObject var searchBar:SearchBar

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

            ChatsScreen(searchBar:searchBar).tabItem {
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
