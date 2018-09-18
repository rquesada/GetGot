//
//  SyncContactsViewController.swift
//  OnBoarding
//
//  Created by Roy Quesada on 7/20/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class SyncContactsViewController: OBBaseViewController, UITextViewDelegate {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var syncContactsButton: ConfirmButton!
    @IBOutlet weak var brandIcon: UIImageView!
    
    var openURL:URL!
    var vm:SyncContactsViewModel?
    var listOfContacts:[Dictionary<String,String>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = SyncContactsViewModel()
        self.brandIcon.image =  Config.sharedInstance.appIcon
        
        let attributedString = NSMutableAttributedString(string:"Contacts from your address book will be uploaded to Twitter on an ongoing basis. You can turn off syncing and remove previously uploaded contacts in your settings. Learn More")
        _ = attributedString.setAsLink(textToFind: "Learn More", linkURL: "https://help.twitter.com/en/using-twitter/upload-your-contacts-to-search-for-friends")
        self.descriptionTextView.attributedText = attributedString
    }
    
    @IBAction func notNowHandler(_ sender: Any) {
        debugPrint("Not now")
        
    }
    
    @IBAction func syncContactsHandler(_ sender: Any) {
        self.vm?.getGetGotUsers(completion: { (users, errorString) in
            self.listOfContacts = users
            self.performSegue(withIdentifier: "followSegue", sender: nil)
        })
        
    }
    
    // MARK : - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.openURL = URL
        self.performSegue(withIdentifier: "openURLSegue2", sender: nil)
        return false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let webVC = nav.topViewController as? WebViewController{
            webVC.openURL = self.openURL
        }else if let vc = segue.destination  as? FollowListViewController{
            vc.contacts = self.listOfContacts
        }
    }
}
