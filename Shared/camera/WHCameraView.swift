//
//  WHCameraView.swift
//  WhatsAppClone
//
//  Created by Anmol Verma on 05/12/20.
//

import Foundation
import SwiftUI

struct WHCameraView:View{
    var body: some View {
        VStack{
            CameraViewController()
                .overlay(CameraTopView()).statusBar(hidden: true)
        }.background(Constants.darkColor)
    }
}


struct CameraTopView: View {
    
    @State var flashEnabled :Bool = false
    
    var body: some View {
        VStack{
            VStack{}.frame(height:10)
            HStack{
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height:20)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 10)
                    Spacer()
                Image(systemName: "moon.fill").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height:20)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 10)
                Image(systemName: flashEnabled == true ? "bolt.fill":"bolt.slash.fill").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height:20)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 10)
            }
            Spacer()
            Image("camera.sep")
            ScrollView (.horizontal, showsIndicators: false) {
                 HStack {
                    Image("testimage")
                    Image("testimage")
                    Image("testimage")
                    Image("testimage")
                    Image("testimage")
                    Image("testimage")
                    Image("testimage")
                 }
            }.frame(height: 100).shadow(color: .black, radius: 10)
            
            HStack{
                Image("galleryicon").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height:20)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 10)
                Spacer()
                Image("capture")
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 10)
                Spacer()
                Image("camera.rotate").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height:20)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(color: .black, radius: 10)
            }
            
        }.navigationBarHidden(true)
    }
}
