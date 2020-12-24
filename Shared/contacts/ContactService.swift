//
//  ContactService.swift
//  WhatsAppClone (iOS)
//
//  Created by Anmol Verma on 24/12/20.
//

import Foundation
import ContactsUI

class ContactService : ObservableObject{
    @Published var contacts = [ChatterContact]()
    @Published var isLoading = false
    
    var contactStore: CNContactStore?
    
    init() {
        getSystemContacts()
    }
    
    private func fetchOrRequestPermissions(completionHandler: @escaping (Bool) -> Void){
        self.contactStore = CNContactStore.init()
        self.contactStore?.requestAccess(for: .contacts){ success,error in
            completionHandler(success)
        }
    }
    
    func getSystemContacts() {
        isLoading = true
        self.fetchOrRequestPermissions(){ success in
            if(success){
                self.getContactsInternal()
            }
            else{
                self.isLoading = false
            }
        }
    }
    
    func getContactsInternal(){
        do{
            let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey] as [CNKeyDescriptor])
            var contacts = [CNContact]()
            try self.contactStore?.enumerateContacts(with: fetchRequest){ contact,stop in
                contacts.append(contact)
            }
            DispatchQueue.main.async {
                self.contacts = contacts.map { CNContact in
                    ChatterContact.fromCNContact(contact: CNContact)
                }
            }
        }catch{
            print("Failed to fetch contact, error: \(error)")
        }
        self.isLoading = false
    }
}
