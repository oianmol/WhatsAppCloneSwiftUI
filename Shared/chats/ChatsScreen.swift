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
    
    
    var body: some View{
            List{
                Header()
                ForEach(self.cars, id: \.self) { car in
                    NavigationLink(destination: ChatWithUserView(name:car)){
                        ChatUserView(name:car).listRowInsets(.init(top: 0,
                                                                   leading: -10,
                                                                   bottom: 0,
                                                                   trailing: -10))
                    }
                }
            }.listStyle(PlainListStyle())
            .resignKeyboardOnDragGesture()
    }
}

struct Header:View{
    var body: some View{
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



