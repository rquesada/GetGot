//
//  Utilities.swift
//  GetGot
//
//  Created by Roy Quesada on 8/24/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

enum ContactsFilter {
    case none
    case mail
    case message
}

class UserContact: NSObject {
    
    var identifier: String?
    var name: String?
    var lastName: String?
    var phoneNumber: [String] = [String]()
    var email: [String] = [String]()
    
    
    init(contact: CNContact) {
        identifier = contact.identifier
        name   = contact.givenName
        lastName = contact.familyName
        for phone in contact.phoneNumbers {
            phoneNumber.append(phone.value.stringValue)
        }
        for mail in contact.emailAddresses {
            email.append(mail.value as String)
        }
    }
    
    func printContact(){
        let info = "id = \(self.identifier!)"
        + " Name =\(self.name!)"
        + " LastName = \(self.lastName!)"
        + " Phones =\(self.phoneNumber)"
        + " Emails = \(self.email)"
        
        debugPrint(info)
    }
    
    override init() {
        super.init()
    }
}

class ContactsUtil: NSObject {
    
    // Return all contacts
    class func getCNContacts() -> [CNContact] { //  ContactsFilter is Enum find it below
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            debugPrint("Error fetching containers") // you can use print()
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                debugPrint("Error fetching containers")
            }
        }
        return results
    }
    
    //Return all contacts emails
    class func getUserContacts() -> [UserContact] {
        var allContacts = [UserContact]()
        let filterdArray = ContactsUtil.getCNContacts().filter { ($0.emailAddresses.count > 0 || $0.phoneNumbers.count > 0) }

        for contact in filterdArray{
             allContacts.append(UserContact(contact: contact))
        }
        return allContacts
    }
}

