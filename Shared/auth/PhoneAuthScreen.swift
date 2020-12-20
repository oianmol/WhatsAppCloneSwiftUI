//
//  PhoneAuthScreen.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 19/12/20.
//

import Foundation
import SwiftUI

struct PhoneAuthScreen : View{
    
    @State var result :String = "Not init yet!"
    
    let authStore = AuthServiceStore()
    
    var body: some View{
        VStack{
            Text(result)
        }.onAppear{
            result = "Loading..."
            DispatchQueue.global(qos: .background).async {
                let authNow = authStore.authorizeNow(phoneNumber: "+918284866938")
                DispatchQueue.main.async {
                    if let response = authNow?.0?.message {
                        result = response
                    }else{
                        if let error = authNow?.1?.localizedDescription{
                            result = error
                            
                        }
                    }
                  }
              
            }
            
        }
    }
}
