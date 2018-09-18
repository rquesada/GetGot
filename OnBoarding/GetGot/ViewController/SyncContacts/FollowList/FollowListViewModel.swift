//
//  FollowListViewModel.swift
//  GetGot
//
//  Created by Roy Quesada on 9/17/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class FollowListViewModel: BaseViewModel {
    
    func follow(list:[String], completion:@escaping (_ error:String?)->()){
        let parameters: [String: Any] = [
            "token": "jf92dkj23943kjdf",
            "username" : "john@example.com",
            "follow" : list
        ]
        let url = AppBaseURL+"/follow"
        
        Alamofire.request(url, method:.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        completion(nil)
                    default:
                        completion("Error")
                    }
                }
            case .failure(_):
                completion("Error")
            }
            
        }
    }

}
