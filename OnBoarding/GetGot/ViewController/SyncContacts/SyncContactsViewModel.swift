//
//  SyncContactsViewModel.swift
//  GetGot
//
//  Created by Roy Quesada on 9/10/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SyncContactsViewModel: BaseViewModel {
    
    func getGetGotUsers(completion:@escaping (_ users:[Dictionary<String, String>]?, _ error:String?)->()){
        
        //ToDo: Use correctly data
        //let jsonContact = ContactsUtil.getJSONContacts()
        
        let parameters: [String: Any] = [
            "contacts": [],
            "username" : "john@example.com",
            "token" : "jf92dkj23943kjdf"
        ]
        let url = AppBaseURL+"/usercontacts"
        
        
        Alamofire.request(url, method:.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success(let value):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        let users = JSON(value)
                        completion(self.parseJsonContacts(userJson: users), nil)
                    default:
                        completion(nil,"Error")
                    }
                }
            case .failure(_):
                completion(nil,"Error")
            }
        }
    }
    
    func parseJsonContacts(userJson:JSON) -> [Dictionary<String, String>]{
        
        var returnValue = [Dictionary<String,String>]()
        for user in userJson.arrayValue{
            var userDict = [String:String]()
            userDict["name"] = user["name"].stringValue
            userDict["userid"] = user["userid"].stringValue
            userDict["profilepic"] = user["profilepic"].stringValue
            returnValue.append(userDict)
        }
        return returnValue
    }
}
