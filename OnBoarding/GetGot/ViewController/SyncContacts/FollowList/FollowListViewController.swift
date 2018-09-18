//
//  FollowListViewController.swift
//  GetGot
//
//  Created by Roy Quesada on 9/17/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit

class FollowListViewController: OBBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    var contacts:[Dictionary<String, Any>]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.myTableView.estimatedRowHeight = 70
//        self.myTableView.rowHeight = UITableViewAutomaticDimension
        self.myTableView.register(UINib(nibName: "FollowTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowTableViewCellID")
    }
    
    
    @IBAction func followHandler(_ sender: Any) {
        
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FollowTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FollowTableViewCellID", for: indexPath) as! FollowTableViewCell
        let userContact = self.contacts[indexPath.row]
        cell.nameLabel.text = userContact["name"] as? String
        if let urlString = userContact["profilepic"] as? String {
            debugPrint("loading \(urlString)")
//            cell.imageView?.load(url: URL(fileURLWithPath: urlString))
            cell.imageView?.downloaded(from: urlString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Select")
    }

}
