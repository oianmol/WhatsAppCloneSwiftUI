//
//  ChatFooterView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 17/12/20.
//

import Foundation
import SwiftUI

struct Footer: View {

    let tableView: Binding<UIScrollView?>
    let yOffset: Binding<CGFloat?>
    @EnvironmentObject var chatViewModel: ChatViewModel
    @State var messageText: String = ""
    @Environment(\.colorScheme) var colorScheme

    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var image: UIImage?

    var body: some View {
        VStack(alignment: .center){
            Divider()
            HStack {
                attachmentbutton

                TextField("", text: $messageText)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                Button {
                    if (messageText.isEmpty) {
                        return
                    }
                    chatViewModel.addChatMessage(chatMessage: ChatMessage(message: messageText, image: nil, myMessage: true))
                    messageText = ""
                    tableView.wrappedValue?.scrollToBottom(animated: true, yOffset: yOffset)
                } label: {
                    Image(systemName: "paperplane").foregroundColor(.blue).padding().imageScale(.large)
                }

            }.background(colorScheme == .dark ? Constants.darkColor : Color.white)
        }

    }

    var attachmentbutton: some View {
        Button {

        } label: {
            Image(systemName: "plus")
                    .foregroundColor(.blue)
                    .padding()
                    .imageScale(.large)
                    .onTapGesture {
                        self.shouldPresentActionScheet = true
                    }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, isPresented: self.$shouldPresentImagePicker, callback: { image in
                            chatViewModel.addChatMessage(chatMessage: ChatMessage(message: nil, image: image, myMessage: true))
                            DispatchQueue.global(qos: .background).async {
                                chatViewModel.uploadFile(data: image.pngData())
                            }
                           
                        })
                    }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = true
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = false
                        }), ActionSheet.Button.cancel()])
                    }
        }
    }
}



