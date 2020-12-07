//
//  SwiftUIView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import SwiftUI
import Introspect

struct ChatWithUserView: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.colorScheme) var colorScheme
    
    @State var tableView: UIScrollView?
    @State var yOffset: CGFloat?

    @ObservedObject var chatViewModel = ChatViewModel()
    
    
    let name:String
    
    
    var body: some View {
        NavigationView {
            
            let body = VStack(alignment:.leading){
                messagesList
                Spacer()
                Section{
                    Footer(tableView:$tableView, yOffset:$yOffset).environmentObject(chatViewModel)
                }
            }
            .navigationBarItems(leading: navigationLeading,trailing: navigationTrailing)
            .widthHeightmatchParent()
            if(colorScheme == .dark){
                body
            }else{
                body.background(Image("Background").resizable().scaledToFill())
            }
        }.navigationBarHidden(true)
        
    }
    
    var messagesList: some View{
        ScrollView{
            ForEach(chatViewModel.messages, id: \.self) { message in
                HStack(alignment: .bottom) {
                    if(message.myMessage == true){
                        Spacer()
                        if(message.message != nil){
                            UserTextMessage(chatMesage:message)
                            UserImage()
                        }else{
                            PictureImage(chatMesage:message)
                            UserImage()
                        }
                    }else{
                        if(message.message != nil){
                            UserImage()
                            UserTextMessage(chatMesage:message)
                        }else{
                            UserImage()
                            PictureImage(chatMesage:message)
                        }
                        Spacer()
                    }
                    
                }.padding(4).widthMatchParent().id(message.hashValue)
                
            }
            
        }.introspectScrollView(customize: { tableView in
            if self.tableView == nil {
                self.tableView = tableView
            } else {
                
                guard let yOffset = self.yOffset
                else { return }
                
                self.tableView?.setContentOffset(CGPoint(x: 0, y: yOffset + 50), animated: true)
                self.tableView?.scrollToBottom(animated: true,yOffset: $yOffset)
            }
        }).resignKeyboardOnTapGesture()
        
    }
    
    var navigationLeading:some View{
        Button(action: { presentation.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
            Image("RandomUser")
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .shadow(radius: 30)
            Text(name)
        }
    }
    var navigationTrailing : some View{
        HStack{
            Button(action: {
                
            }, label: {
                Image(systemName: "video")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            })
            Spacer()
            Button(action: {}, label: {
                Image(systemName: "phone")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            })
        }
    }
}

struct UserImage : View{
    var body: some View{
        Image("RandomUser")
            .resizable()
            .frame(width: 20, height: 20, alignment: .center)
            .cornerRadius(10).padding(.trailing, 10)
    }
}

struct PictureImage:View{
    let chatMesage:ChatMessage
    
    var body: some View{
        VStack{
            Image(uiImage: chatMesage.image!)
                .resizable().frame(width:150,height:150)
            
        }.background(Color.blue)
        .cornerRadius(25)
    }
}

struct UserTextMessage: View{
    
    let chatMesage:ChatMessage
    
    var body: some View{
        Text(chatMesage.message!).padding(10)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(10)
    }
}


struct Footer: View{
    
    let tableView:Binding<UIScrollView?>
    let yOffset: Binding<CGFloat?>
    @EnvironmentObject var chatViewModel:ChatViewModel
    @State var messageText:String = ""
    @Environment(\.colorScheme) var colorScheme
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var image: UIImage?
    
    var body: some View{
        HStack{
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
                    .padding()
                    .imageScale(.large)
                    .onTapGesture { self.shouldPresentActionScheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,isPresented: self.$shouldPresentImagePicker, callback: { image in
                            chatViewModel.addChatMessage(chatMessage: ChatMessage(message: nil, image: image,myMessage:true))
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
            
            TextField("",text: $messageText)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                if(messageText.isEmpty){
                    return
                }
                chatViewModel.addChatMessage(chatMessage: ChatMessage(message: messageText, image: nil,myMessage:true))
                messageText = ""
                tableView.wrappedValue?.scrollToBottom(animated: true,yOffset: yOffset)
            } label: {
                Image(systemName: "paperplane").foregroundColor(.blue).padding().imageScale(.large)
            }
            
        }.frame(height:44).background(colorScheme == .dark ? Constants.darkColor : Color.white)
        
    }
}


extension UIScrollView {

    func scrollToBottom(animated: Bool,
                        yOffset: Binding<CGFloat?>) {

        let y = contentSize.height - frame.size.height
        if y < 0 { return }

        yOffset.wrappedValue = y
    }
}
