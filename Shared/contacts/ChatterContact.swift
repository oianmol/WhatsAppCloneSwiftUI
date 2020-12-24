//
//  ChatterContact.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 24/12/20.
//

import Foundation
import ContactsUI

struct ChatterContact: Hashable,Equatable {
    static func == (lhs: ChatterContact, rhs: ChatterContact) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var givenName: String
    var lastName: String

    var numbers: [PhoneNumber]

    var systemContact: CNContact? // --> This one is important! We keep a reference to later make it easier for editing the same contact.

    struct PhoneNumber : Hashable,Equatable  { // --> We also have a PhoneNumber struct as they can have labels and we want to display them
        var label: String
        var number: String
        static func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
            return lhs.number == rhs.number
        }
    }

    init(givenName: String, lastName: String, numbers: [PhoneNumber], systemContact: CNContact) {
        self.givenName = givenName
        self.lastName = lastName
        self.numbers = numbers
        self.systemContact = systemContact
    }

    init(givenName: String, lastName: String, numbers: [PhoneNumber]) {
        self.givenName = givenName
        self.lastName = lastName
        self.numbers = numbers
    }

    static func fromCNContact(contact: CNContact) -> ChatterContact {
        let numbers = contact.phoneNumbers.map({
            (value: CNLabeledValue<CNPhoneNumber>) -> ChatterContact.PhoneNumber in

            let localized = CNLabeledValue<NSString>.localizedString(forLabel: value.label ?? "")

            return ChatterContact.PhoneNumber.init(label: localized, number: value.value.stringValue)

        })
        
        return self.init(givenName: contact.givenName,
                         lastName: contact.familyName,
                         numbers: numbers,
                         systemContact: contact)
    }

    func fullName() -> String {
        return "\(self.givenName) \(self.lastName)"
    }
}
