//
//  AuthServiceStore.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 20/12/20.
//

import Foundation
import GRPC
import NIO
import NIOHPACK

typealias Pair = (AuthResponse?,Error?)

final class AuthServiceStore{
    
    func verifyOtp(otp:String,phoneNumber:String) -> Pair? {
        do{
            var authRequest = AuthVerify()
            authRequest.phoneNumber = phoneNumber
            authRequest.code = otp
            let clientConnection = getClientConnection()
            let authService = AuthServiceClient(channel: clientConnection)
            let authResult = try authService.verifyOtp(authRequest,callOptions: makeOptions()).response.wait()
            return Pair(authResult,nil)
        }catch{
            return Pair(nil,error)
        }
    }

    func authorizeNow(phoneNumber:String) -> Pair? {
        do{
            var authRequest = AuthRequest()
            authRequest.phoneNumber = phoneNumber
            
            let clientConnection = getClientConnection()
            let authService = AuthServiceClient(channel: clientConnection)
            let authResult = try authService.authorize(authRequest,callOptions: makeOptions()).response.wait()
            return Pair(authResult,nil)
        }catch{
            return Pair(nil,error)
        }
    }
    
    func makeOptions() -> CallOptions {
        
        var header = HPACKHeaders()
        header.add(name: "platform", value: "ios")
     
        var option = CallOptions(customMetadata: header)
        option.cacheable = false
        option.timeLimit = TimeLimit.timeout(TimeAmount.seconds(15))
        return option
    }
    
    func getClientConnection() -> ClientConnection {
        let mtelg = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let config = ClientConnection.Configuration(target: .hostAndPort("192.168.1.15", 8080), eventLoopGroup: mtelg)
        
        let connection = ClientConnection(configuration: config)
        return connection
    }

}
