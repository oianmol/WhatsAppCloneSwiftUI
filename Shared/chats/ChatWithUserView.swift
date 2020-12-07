//
//  SwiftUIView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import SwiftUI

struct ChatWithUserView: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.colorScheme) var colorScheme
    

    @ObservedObject var chatViewModel = ChatViewModel()
    
    
    let name:String
    
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                messagesList
                Spacer()
                Footer().environmentObject(chatViewModel)
            }
            .navigationBarItems(leading: navigationLeading,trailing: navigationTrailing)
            .widthHeightmatchParent()
        }.navigationBarHidden(true)
      
    }
    
    var messagesList: some View{
        ScrollView{
            LazyVStack{
                ForEach(chatViewModel.messages, id: \.self) { car in
                    HStack(alignment: .bottom) {
                        Spacer()
                        if(car.message != nil){
                            Text(car.message!).padding(10)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                            Image("RandomUser")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .cornerRadius(10).padding(.trailing, 10)
                        }else{
                            VStack{
                                Image(uiImage: car.image!)
                                    .resizable().frame(width:150,height:150)
                            
                            }.background(Color.blue)
                            .cornerRadius(25)
                            Image("RandomUser")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .cornerRadius(10).padding(.trailing, 10)
                        }
                    
                    }.padding(4).widthMatchParent()
                    
                }
            }
        }.resignKeyboardOnDragGesture()
        
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
            Image(systemName: "video")
                .foregroundColor(.blue)
                .imageScale(.large)
            Spacer()
            Image(systemName: "phone")
                .foregroundColor(.blue)
                .imageScale(.large)
        }
    }
}


struct Footer: View{
    
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
                            chatViewModel.messages.append(ChatMessage(message: nil, image: image))

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

            TextEditor(text: $messageText)

            Button {
                if(messageText.isEmpty){
                    return
                }
                chatViewModel.messages.append(ChatMessage(message: messageText, image: nil))
                messageText = ""
            } label: {
                Image(systemName: "paperplane").foregroundColor(.blue).padding().imageScale(.large)
            }
            
        }.frame(height:44)
        
    }
}


