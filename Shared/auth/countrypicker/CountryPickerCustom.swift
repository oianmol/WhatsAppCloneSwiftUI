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

    let countryPicker = CountryPickerView()

    func makeUIView(context: Context) -> CountryPickerView {
        countryPicker.setCountryByPhoneCode("+91")
        return countryPicker
    }

    func updateUIView(_ uiView: CountryPickerView, context: Context) {

    }
}
