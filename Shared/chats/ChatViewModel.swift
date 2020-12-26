//
//  ChatViewModel.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 06/12/20.
//

import Foundation
import SwiftUI


typealias PairResponse = (FileUploadResponseMessage?,Error?)


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
    
    func uploadFile(data:Data?) -> PairResponse?{
        
        do{
            
            let clientConnection = GrpcChattConnection.getClientConnection()
            if let connection = clientConnection {
                let fileTransferService = FileTransferServiceClient(channel: connection)
                let uploadStreamingCall = fileTransferService.uploadFile(callOptions: GrpcChattConnection.makeOptions())
                
                
                let dataLen = data!.count
                let fullChunks = Int(dataLen / 1024) // 1 Kbyte
                let totalChunks = fullChunks + (dataLen % 1024 != 0 ? 1 : 0)
                
                print(totalChunks)
                for chunkCounter in 0..<totalChunks
                {
                    var chunk:Data
                    let chunkBase = chunkCounter * 1024
                    var diff = 1024
                    if chunkCounter == totalChunks - 1
                    {
                        diff = dataLen - chunkBase
                    }
                    
                    let range  = chunkBase..<(chunkBase + diff)
                    chunk = data!.subdata(in: range)
                    
                    var fileUpload = FileUploadType()
                    fileUpload.fileName = "image.png"
                    fileUpload.fileData = chunk
                    
                    try uploadStreamingCall.sendMessage(fileUpload).wait()
                    print("uploaded chunk ")
                }
                try uploadStreamingCall.sendEnd().wait()
                let uploadResult = try uploadStreamingCall.response.wait()
                print("uploaded chunk complete")
                print(uploadResult.success)
                return PairResponse(uploadResult,nil)
            }else{
                return PairResponse(nil,GRPCError.runtimeError("Failed to load cert"))
            }
            
        }catch{
            return PairResponse(nil,error)
        }
    }
    
}


struct ChatMessage : Hashable{
    var message: String?
    var image: UIImage?
    var myMessage: Bool?
}
