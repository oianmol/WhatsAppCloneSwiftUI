//
//  ChatUserView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct ChatUserView:View{
    
    let name:String
    
    var body: some View{
        HStack(alignment:.center){
            Image("RandomUser")
                .frame(width: 50, height: 50)
                       .clipShape(Circle())
                       .shadow(radius: 40)

            VStack(alignment:.leading){
                HStack{
                    Text(name)
                    Spacer()
                    Text("4:16 PM").foregroundColor(.gray)
                }
                Text("✓✓ Do not fail to try").foregroundColor(.gray)
            }
            Spacer()
        }.widthMatchParent().padding()
    }
}
