//
//  ChatUserView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct ChatUserView:View{
    
    let name: ChatterContact
    
    var randomUser: some View{
        Image("RandomUser")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .shadow(radius: 40)
    }
    
    var body: some View{
        HStack(alignment:.center){
            if let data = name.systemContact?.thumbnailImageData{
                if let uiImage = UIImage(data: data){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 40)
                    
                }else{
                    randomUser
                }
                
            }else{
                randomUser
            }
            VStack(alignment:.leading){
                HStack{
                    Text(name.fullName())
                    Spacer()
                    Text("4:16 PM").foregroundColor(.gray)
                }
                Text("✓✓ Do not fail to try").foregroundColor(.gray)
            }
            Spacer()
        }.widthMatchParent().padding()
    }
}
