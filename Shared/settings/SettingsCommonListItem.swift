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
    let divider:Bool
    
    var body: some View{
        VStack{
            HStack{
                Image(imageId).imageScale(.small)
                Text(text)
                Spacer()
                Image("caraticon")
            }.widthMatchParent().frame(height:20).padding(10)
            if(divider){
                Divider().padding(EdgeInsets.init(top: 0, leading: 50, bottom: 0, trailing: 0))
            }
        }
      
    }
}
