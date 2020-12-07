//
//  ChatViewModel.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 06/12/20.
//

import Foundation
import SwiftUI

final class ChatViewModel : ObservableObject{
   @Published var messages : [ChatMessage] = []
    
    func addChatMessage(chatMessage:ChatMessage){
        messages.append(chatMessage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            var otherMessage = chatMessage
            otherMessage.myMessage = false
            self.messages.append(otherMessage)
        }
    }

}


struct ChatMessage : Hashable{
    var message: String?
    var image: UIImage?
    var myMessage: Bool?
}
