//
//  GrpcChattConnection.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 26/12/20.
//

import Foundation
import GRPC
import NIO
import NIOSSL
import NIOHPACK

final class GrpcChattConnection {
   static func makeOptions() -> CallOptions {
        
        var header = HPACKHeaders()
        header.add(name: "platform", value: "ios")
        
        var option = CallOptions(customMetadata: header)
        option.cacheable = false
        option.timeLimit = TimeLimit.timeout(TimeAmount.seconds(15))
        return option
    }
    
    static func getClientConnection() -> ClientConnection? {
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
