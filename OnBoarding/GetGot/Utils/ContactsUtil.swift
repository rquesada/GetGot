//
//  Utilities.swift
//  GetGot
//
//  Created by Roy Quesada on 8/24/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import Contacts
import SwiftyJSON

class ContactsUtil: NSObject {
    
    // Return all contacts
    class func getCNContacts() -> [CNContact] {
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactNamePrefixKey,
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactPreviousFamilyNameKey,
            CNContactNameSuffixKey,
            CNContactNicknameKey,
            CNContactOrganizationNameKey,
            CNContactDepartmentNameKey,
            CNContactJobTitleKey,
            CNContactPhoneticGivenNameKey,
            CNContactPhoneticMiddleNameKey,
            CNContactPhoneticFamilyNameKey,
            CNContactPhoneticOrganizationNameKey,
            CNContactBirthdayKey,
            CNContactNonGregorianBirthdayKey,
            CNContactNoteKey,
            CNContactTypeKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactSocialProfilesKey,
            CNContactInstantMessageAddressesKey,
            CNContactUrlAddressesKey,
            
            CNContactPostalAddressesKey,// no
            CNContactDatesKey,//no
            CNContactRelationsKey, //no
            CNContactImageDataKey,//no
            CNContactThumbnailImageDataKey,//no
            CNContactImageDataAvailableKey//no
            ] as [Any]
        
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
    
    
    static func getJSONContacts() -> JSON{
        var array = [[String: Any?]]()
        for contact in ContactsUtil.getCNContacts(){
            array.append(contact.getDictionary())
        }
        return JSON(array)
    }
    
    static func getContacts() -> [[String: Any?]]{
        var array = [[String: Any?]]()
        for contact in ContactsUtil.getCNContacts(){
            array.append(contact.getDictionary())
        }
        return array
    }
}


extension CNContact{
    
    //Convert CNContact -> JSON
    func getDictionary() -> [String: Any?]{
        var dict = [String: Any?]()
        
        dict["identifier"] = self.identifier
        
        if self.namePrefix != ""{ dict["namePrefix"] = self.namePrefix }
        if self.givenName != ""{ dict["givenName"] = self.givenName }
        if self.middleName != ""{ dict["middleName"] = self.middleName }
        if self.familyName != "" { dict["familyName"] = self.familyName }
        if self.previousFamilyName != "" { dict["previousFamilyName"] = self.previousFamilyName }
        if self.nameSuffix != "" { dict["nameSuffix"] = self.nameSuffix }
        if self.nickname != "" { dict["nickname"] = self.nickname }
        if self.organizationName != "" { dict["organizationName"] = self.organizationName }
        if self.departmentName != "" { dict["departmentName"] = self.departmentName }
        if self.jobTitle != "" { dict["jobTitle"] = self.jobTitle }
        if self.phoneticGivenName != "" { dict["phoneticGivenName"] = self.phoneticGivenName }
        if self.phoneticMiddleName != "" { dict["phoneticMiddleName"] = self.phoneticMiddleName }
        if self.phoneticFamilyName != "" { dict["phoneticFamilyName"] = self.phoneticFamilyName }
        if self.phoneticOrganizationName != "" { dict["phoneticOrganizationName"] = self.phoneticOrganizationName }
        if let timestamp = self.birthday?.date{ dict["birthday"] = "\(timestamp)" }
        if let timestampN = self.nonGregorianBirthday?.date{ dict["nonGregorianBirthday"] = "\(timestampN)" }
        if self.note != "" { dict["note"] = self.note }
        if self.imageData != nil { dict["imageData"] = self.imageData }
        if self.thumbnailImageData != nil { dict["thumbnailImageData"] = self.thumbnailImageData }
        
        dict["contactType"] = self.contactType.rawValue == 0 ? "person" : "organization"
        
        if self.phoneNumbers.count > 0{
            var phones = [String]()
            for phone in self.phoneNumbers{
                phones.append(phone.value.stringValue)
            }
            dict["phones"] = phones
        }
        
        if self.emailAddresses.count > 0{
            var emails = [String]()
            for email in self.emailAddresses{
                emails.append(email.value as String)
            }
            dict["emails"] = emails
        }
        
        if self.socialProfiles.count > 0 {
            var socialDict = [String:String]()
            for cnlabel in self.socialProfiles{
                socialDict[cnlabel.value.service] = cnlabel.value.username
            }
            dict["socialProfiles"] = socialDict
        }
        
        if self.instantMessageAddresses.count > 0 {
            var messagesDict = [String:String]()
            for cnlabel in self.instantMessageAddresses{
                messagesDict[cnlabel.value.service] = cnlabel.value.username
            }
            dict["instantMessageAddresses"] = messagesDict
        }
        
        if self.urlAddresses.count > 0 {
            var urlDict = [String]()
            for cnLabel in self.urlAddresses{
                urlDict.append(cnLabel.value as String)
            }
            dict["urlAddresses"] = urlDict
        }
        return dict
    }
}

