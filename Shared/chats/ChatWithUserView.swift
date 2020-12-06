//
//  SwiftUIView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import SwiftUI

struct ChatWithUserView: View {
    
    
    
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var chatViewModel = ChatViewModel()
    
    
    let name:String
    
    
    var body: some View {
        VStack(alignment:.leading){
            messagesList
            Spacer()
            Footer().environmentObject(chatViewModel)
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: navigationLeading,trailing: navigationTrailing).widthHeightmatchParent()
    }
    
    var messagesList: some View{
        ScrollView{
            LazyVStack{
                ForEach(chatViewModel.messages, id: \.self) { car in
                    HStack(alignment: .bottom) {
                        Spacer()
                        Text(car).padding(10)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        Image("RandomUser")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .cornerRadius(10).padding(.trailing, 10)
                    }.widthMatchParent()
                    
                }
            }
        }.resignKeyboardOnDragGesture().background(Image("Background"))
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


struct Footer:View{
    
    @EnvironmentObject var chatViewModel:ChatViewModel
    @State var messageText:String = ""
    
    var body: some View{
        HStack{
            Image(systemName: "plus").foregroundColor(.blue).padding().imageScale(.large)
            TextField("Send Message..", text: $messageText).textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                chatViewModel.messages.append(messageText)
                messageText = ""
            } label: {
                Image(systemName: "paperplane").foregroundColor(.blue).padding().imageScale(.large)
            }
            
        }.frame(height:44)
        .background(Color.white)
    }
}


