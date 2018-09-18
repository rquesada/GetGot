//
//  FollowListViewController.swift
//  GetGot
//
//  Created by Roy Quesada on 9/17/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import SDWebImage

class FollowListViewController: OBBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    var contacts:[Dictionary<String, Any>]!
    var followList = [String]()
    var vm:FollowListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UINib(nibName: "FollowTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowTableViewCellID")
        self.vm = FollowListViewModel()
    }
    
    
    @IBAction func followHandler(_ sender: Any) {
        self.vm?.follow(list: self.followList, completion: { errorString in
            if errorString != nil{
                debugPrint("Log error")
            }else{
                debugPrint("GO TO Main")
                self.parent?.parent?.dismiss(animated: false, completion: nil)
            }
        })
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
        cell.userID = userContact["userid"] as? String
        if let urlString = userContact["profilepic"] as? String {
            debugPrint("loading \(urlString)")
//            cell.imageView?.load(url: URL(fileURLWithPath: urlString))
//            cell.imageView?.downloaded(from: urlString)
//            let urlImage = URL(fileURLWithPath: urlString)
//            cell.imageView?.sd_setImage(with: urlImage, placeholderImage: UIImage(named: "place_holder"), options: .transformAnimatedImage, completed: nil )
        }
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:FollowTableViewCell = tableView.cellForRow(at: indexPath) as! FollowTableViewCell
        if cell.isSelected{
            cell.isSelected = false
            if cell.accessoryType == UITableViewCellAccessoryType.none{
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                self.followList.append(cell.userID)
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.none
                self.followList = self.followList.filter{ $0 != cell.userID}
            }
        }
        
        debugPrint("result = \(self.followList)")
    }

}
