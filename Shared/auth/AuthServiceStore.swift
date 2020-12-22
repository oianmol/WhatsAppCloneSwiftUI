//
//  AuthServiceStore.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 20/12/20.
//

import Foundation
import GRPC
import NIO
import NIOSSL
import NIOHPACK
import KeychainSwift

typealias Pair = (AuthResponse?,Error?)

final class AuthServiceStore : ObservableObject{
    
    private let keyChainSwift = KeychainSwift()
    @Published var isAuthorizedNow: Bool? // Step 2
    
    func setLoggedIn(authResponse:AuthResponse){
        keyChainSwift.set(true, forKey: Constants.IS_AUTH)
        isAuthorizedNow = true
    }
    
    func isLoggedIn()->Bool{
        if let isAuth =  keyChainSwift.getBool(Constants.IS_AUTH){
            return isAuth == true
        }else{
            return false
        }
    }
    
    func logOut(){
        keyChainSwift.clear()
        isAuthorizedNow = false
    }
    
    func verifyOtp(otp:String,phoneNumber:String) -> Pair? {
        do{
            var authRequest = AuthVerify()
            authRequest.phoneNumber = phoneNumber
            authRequest.code = otp
            let clientConnection = getClientConnection()
            if let connection = clientConnection {
                let authService = AuthServiceClient(channel: connection)
                let authResult = try authService.verifyOtp(authRequest,callOptions: makeOptions()).response.wait()
                return Pair(authResult,nil)
            }else{
                return Pair(nil,GRPCError.runtimeError("Failed to load cert"))
            }
        }catch{
            return Pair(nil,error)
        }
    }
    
    func authorizeNow(phoneNumber:String) -> Pair? {
        do{
            var authRequest = AuthRequest()
            authRequest.phoneNumber = phoneNumber
            
            let clientConnection = getClientConnection()
            if let connection = clientConnection {
                let authService = AuthServiceClient(channel: connection)
                let authResult = try authService.authorize(authRequest,callOptions: makeOptions()).response.wait()
                return Pair(authResult,nil)
            }else{
                return Pair(nil,GRPCError.runtimeError("Failed to load cert"))
            }
            
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
    
    func getClientConnection() -> ClientConnection? {
        do {
           
            let certfile = Bundle.main.path(forResource: "my-public-key-cert", ofType: ".pem")!
           
            let config = ClientConnection.Configuration(
                target: .hostAndPort("192.168.1.15", 8443),
                eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount),
                tls: .init(certificateChain: try NIOSSLCertificate.fromPEMFile(certfile).map { .certificate($0) },
                           certificateVerification: .none))
            
            let connection = ClientConnection(configuration: config)
            return connection
        } catch {
            print("ERROR\n\(error)")
            return nil
        }
    }
    
}

enum GRPCError: Error {
    case runtimeError(String)
}
