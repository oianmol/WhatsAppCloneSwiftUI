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
    
    @State private var searchText : String = ""

    var body: some View{
        SearchNavigation(text: $searchText, search: {}, cancel: {}){
            List{
                HStack{
                    Button("Broadcast Lists", action: {
                        
                    }).padding(4).foregroundColor(.blue)
                    Spacer()
                        Button("New Group", action: {
                            
                        }).padding(4).foregroundColor(.blue)
                }
                ForEach(self.cars.filter {
                                      self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                                  }, id: \.self) { car in
                    Text(car)
                                  }
            }.listStyle(PlainListStyle())
            .resignKeyboardOnDragGesture()
            .navigationTitle("Chats")
            .navigationBarItems(leading: Button("Edit"){},trailing: Button(action:{}){
                Image(systemName: "pencil.circle")
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
