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

}


struct ChatMessage : Hashable{
    var message: String?
    var image: UIImage?
}
