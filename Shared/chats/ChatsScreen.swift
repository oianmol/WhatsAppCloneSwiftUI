//
//  ChatsScreen.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI


struct ChatsScreen : View{
    let cars = ["Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean", "Mitsubishi Lancer", "Audi RS6","Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean", "Mitsubishi Lancer", "Audi RS6"]
    
    @ObservedObject var searchBar: SearchBar = SearchBar()

    var body: some View{
        NavigationView{
            List{
                HStack{
                    Button("Broadcast Lists", action: {
                        
                    }).foregroundColor(.blue)
                    Spacer()
                    Button("New Group", action: {
                        
                    }).foregroundColor(.blue)
                }.listRowInsets(.init(top: 0,
                                      leading: 10,
                                      bottom: 0,
                                      trailing: 10))
                ForEach(self.cars.filter {
                    self.searchBar.text.isEmpty ? true : $0.lowercased().contains(self.searchBar.text.lowercased())
                }, id: \.self) { car in
                    ChatUserView(name:car).listRowInsets(.init(top: 0,
                                                               leading: -10,
                                                               bottom: 0,
                                                               trailing: -10))
                }
            }.listStyle(PlainListStyle())
            .onAppear{
                UITableView.appearance().separatorStyle = .singleLine
            }
            .resignKeyboardOnDragGesture()
            .add(self.searchBar)
            .navigationTitle("Chats")
            .navigationBarItems(leading: Button("Edit"){},trailing: Button(action:{}){
                Image(systemName: "pencil")
            })
        }
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }

}



