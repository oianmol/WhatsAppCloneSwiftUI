//
//  PhoneAuthScreen.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 19/12/20.
//

import Foundation
import SwiftUI
import CountryPickerView
import KeychainSwift

struct PhoneAuthScreen : View{
    
    @State var result :String = "We will send you a 6 digits OTP"
    @State var phone:String = ""
    @EnvironmentObject var authStore: AuthServiceStore
    @State private var showingAlert = false
    @State private var otp = ""
    @State private var otpSent = false
    @State private var otpVerified = false
    let countryPicker = CountryPickerView()
    @Environment(\.colorScheme) var colorScheme

    var body: some View{
        NavigationView{
            VStack{
                Text(result)

                Image("WhatsAppWeb").resizable().frame(width: 100,height: 100).padding()

                HStack{
                    if(otpSent){
                        TextField("Enter OTP",text:$otp).keyboardType(.numberPad).padding()
                    }else{
                        CountryPickerCustom(countryPicker:countryPicker).padding()
                        TextField("Enter Phone",text:$phone).keyboardType(.numberPad)
                    }
                }
                Button(action: {
                    if(otpSent){
                        if(otp.isEmpty){
                            self.showingAlert = true
                            return
                        }
                        result = "Verifying OTP..."
                        verifyOtp()
                    }else{
                        if(phone.isEmpty){
                            self.showingAlert = true
                            return
                        }
                        result = "Requesting OTP..."
                        authorize()
                    }

                }, label: {
                    Text(otpSent ? "Verify OTP" : "Request OTP")
                }).padding().alert(isPresented: $showingAlert) {
                    Alert(title: Text("Important message"), message: Text("Input not valid!"), dismissButton: .default(Text("Ok!")))
                }
                NavigationLink(destination: HomeScreen(), isActive:$otpVerified){
                    EmptyView()
                }
            }.resignKeyboardOnTapGesture()
            .background(Constants.lightDarkColor(colorScheme: colorScheme))
            .navigationBarChatterColor()
            .navigationTitle(Text("Verify Phone"))
        }
    }

    func verifyOtp(){
        DispatchQueue.global(qos: .background).async {
            let authNow = authStore.verifyOtp(otp:otp, phoneNumber: countryPicker.selectedCountry.phoneCode+phone)
            DispatchQueue.main.async {
                if let response = authNow?.0?.message {
                    if(authNow!.0!.code == 200){
                        authStore.setLoggedIn(authResponse: authNow!.0!)
                        otpVerified = true
                    }
                    result = response
                }else{
                    if let error = authNow?.1?.localizedDescription{
                        result = error
                    }
                }
              }

        }
    }

    func authorize(){
                    DispatchQueue.global(qos: .background).async {
                        let authNow = authStore.authorizeNow(phoneNumber: countryPicker.selectedCountry.phoneCode+phone)
                        DispatchQueue.main.async {
                            if let response = authNow?.0?.message {
                                if(authNow!.0!.code == 200){
                                    otpSent = true
                                }
                                result = response
                            }else{
                                if let error = authNow?.1?.localizedDescription{
                                    result = error
                                }
                            }
                          }

                    }
    }
}
