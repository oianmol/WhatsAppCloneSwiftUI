//
//  CountryPickerCustom.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 20/12/20.
//

import Foundation
import CountryPickerView
import SwiftUI

struct CountryPickerCustom: UIViewRepresentable {

    let countryPicker :CountryPickerView
    
    @Environment(\.colorScheme) var colorScheme

    init(countryPicker:CountryPickerView){
        self.countryPicker = countryPicker
        countryPicker.setCountryByPhoneCode("+91")
        countryPicker.textColor = colorScheme == .light ? UIColor.white : UIColor.black
    }


    func makeUIView(context: Context) -> CountryPickerView {
        return countryPicker
    }

    func updateUIView(_ uiView: CountryPickerView, context: Context) {
        countryPicker.textColor = colorScheme == .dark ? UIColor.white : UIColor.black
    }
}
