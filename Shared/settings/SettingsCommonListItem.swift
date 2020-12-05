//
//  SettingsCommonListItem.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct SettingsCommonListItem:View{
    
    let imageId:String
    let text:String
    
    var body: some View{
        VStack{
            HStack{
                Image(imageId)
                Text(text)
                Spacer()
                Image("caraticon")
            }.widthMatchParent().frame(height:20).padding(EdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            Divider().padding(EdgeInsets.init(top: 0, leading: 50, bottom: 0, trailing: 0))
        }
      
    }
}
