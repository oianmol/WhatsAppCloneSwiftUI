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
                Image(systemName: "xmark").foregroundColor(.white).padding()
                    Spacer()
                Image(systemName: "moon.fill").foregroundColor(.white).padding()
                Image(systemName: flashEnabled == true ? "bolt.fill":"bolt.slash.fill").foregroundColor(.white).padding()
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
            }.frame(height: 100)
            
            HStack{
                Image("galleryicon").padding()
                Spacer()
                Image("capture").padding()
                Spacer()
                Image("camera.rotate").padding()
            }
            
        }.navigationBarHidden(true)
    }
}
