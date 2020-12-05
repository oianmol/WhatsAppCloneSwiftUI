//
//  SwiftUIView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import SwiftUI

struct ChatWithUserView: View {
    
    let cars = ["Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean", "Mitsubishi Lancer", "Audi RS6","Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean", "Mitsubishi Lancer", "Audi RS6"]
    
    @Environment(\.presentationMode) var presentation
    
    @State var messageText:String = ""
    
    let name:String
    
    var body: some View {
            VStack(alignment:.leading){
                List{
                    ForEach(self.cars, id: \.self) { car in
                        Text(car)
                    }
                }.listStyle(PlainListStyle())
                Spacer()
                HStack{
                    Image(systemName: "plus").foregroundColor(.blue).padding().imageScale(.large)
                    TextField("Send Message..", text: $messageText).textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "camera").foregroundColor(.blue).padding().imageScale(.large)
                }.frame(height:44)
            }.navigationBarBackButtonHidden(true).navigationBarItems(leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Image("RandomUser")
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .shadow(radius: 30)
                Text(name)
            },trailing: HStack{
                Image(systemName: "video")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Spacer()
                Image(systemName: "phone")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }).widthHeightmatchParent()
    }
}

