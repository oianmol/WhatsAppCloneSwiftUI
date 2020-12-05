//
//  SettingsUserHeader.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct SettingsUserHeader : View{
    var body: some View {
        VStack(alignment:.leading){
            HStack(alignment:.center){
                Image("RandomUser")
                    .frame(width: 55, height: 55)
                           .clipShape(Circle())
                           .shadow(radius: 55)
    
                VStack(alignment:.leading){
                    Text("Cool guy").font(.title2)
                    Text("Do not fail to try").foregroundColor(.gray)
                }
                Spacer()
                Image("caraticon")
            }.widthMatchParent().padding()
        }.background(Color.white)
    }
}
