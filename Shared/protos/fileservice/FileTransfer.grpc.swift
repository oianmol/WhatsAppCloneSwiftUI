//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: FileTransfer.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `FileTransferServiceClient`, then call methods of this protocol to make API calls.
internal protocol FileTransferServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: FileTransferServiceClientInterceptorFactoryProtocol? { get }

  func uploadFile(
    callOptions: CallOptions?
  ) -> ClientStreamingCall<FileUploadType, FileUploadResponseMessage>

  func downloadFile(
    _ request: FileDownloadRequestMessage,
    callOptions: CallOptions?,
    handler: @escaping (FileDownloadResponseMessage) -> Void
  ) -> ServerStreamingCall<FileDownloadRequestMessage, FileDownloadResponseMessage>
}

extension FileTransferServiceClientProtocol {
  internal var serviceName: String {
    return "FileTransferService"
  }

  /// Client streaming call to uploadFile
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata, status and response.
  internal func uploadFile(
    callOptions: CallOptions? = nil
  ) -> ClientStreamingCall<FileUploadType, FileUploadResponseMessage> {
    return self.makeClientStreamingCall(
      path: "/FileTransferService/uploadFile",
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeuploadFileInterceptors() ?? []
    )
  }

  /// Server streaming call to downloadFile
  ///
  /// - Parameters:
  ///   - request: Request to send to downloadFile.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  internal func downloadFile(
    _ request: FileDownloadRequestMessage,
    callOptions: CallOptions? = nil,
    handler: @escaping (FileDownloadResponseMessage) -> Void
  ) -> ServerStreamingCall<FileDownloadRequestMessage, FileDownloadResponseMessage> {
    return self.makeServerStreamingCall(
      path: "/FileTransferService/downloadFile",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makedownloadFileInterceptors() ?? [],
      handler: handler
    )
  }
}

internal protocol FileTransferServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'uploadFile'.
  func makeuploadFileInterceptors() -> [ClientInterceptor<FileUploadType, FileUploadResponseMessage>]

  /// - Returns: Interceptors to use when invoking 'downloadFile'.
  func makedownloadFileInterceptors() -> [ClientInterceptor<FileDownloadRequestMessage, FileDownloadResponseMessage>]
}

internal final class FileTransferServiceClient: FileTransferServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: FileTransferServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the FileTransferService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: FileTransferServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol FileTransferServiceProvider: CallHandlerProvider {
  var interceptors: FileTransferServiceServerInterceptorFactoryProtocol? { get }

  func uploadFile(context: UnaryResponseCallContext<FileUploadResponseMessage>) -> EventLoopFuture<(StreamEvent<FileUploadType>) -> Void>

  func downloadFile(request: FileDownloadRequestMessage, context: StreamingResponseCallContext<FileDownloadResponseMessage>) -> EventLoopFuture<GRPCStatus>
}

extension FileTransferServiceProvider {
  internal var serviceName: Substring { return "FileTransferService" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handleMethod(
    _ methodName: Substring,
    callHandlerContext: CallHandlerContext
  ) -> GRPCCallHandler? {
    switch methodName {
    case "uploadFile":
      return CallHandlerFactory.makeClientStreaming(
        callHandlerContext: callHandlerContext,
        interceptors: self.interceptors?.makeuploadFileInterceptors() ?? []
      ) { context in
        self.uploadFile(context: context)
      }

    case "downloadFile":
      return CallHandlerFactory.makeServerStreaming(
        callHandlerContext: callHandlerContext,
        interceptors: self.interceptors?.makedownloadFileInterceptors() ?? []
      ) { context in
        return { request in
          self.downloadFile(request: request, context: context)
        }
      }

    default:
      return nil
    }
  }
}

internal protocol FileTransferServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'uploadFile'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeuploadFileInterceptors() -> [ServerInterceptor<FileUploadType, FileUploadResponseMessage>]

  /// - Returns: Interceptors to use when handling 'downloadFile'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makedownloadFileInterceptors() -> [ServerInterceptor<FileDownloadRequestMessage, FileDownloadResponseMessage>]
}
