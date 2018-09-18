//
//  MainViewModel.swift
//  GetGot
//
//  Created by Roy Quesada on 9/18/18.
//  Copyright © 2018 Roy Quesada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewModel: BaseViewModel {
    let currentVersion = 10
    
    func isLastestVersion(completion:@escaping (_ isUpdate:Bool)->()){
        let url = AppBaseURL+"/latestversion?platform=ios"
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
            case .success(let value):
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        let json = JSON(value)
                        let requiredVersion = json["ios"].intValue
                        if requiredVersion <= self.currentVersion{
                            completion(true)
                        }else{
                            completion(false)
                        }
                        
                    default:
                        completion(true)
                    }
                }
            case .failure(_):
                completion(true)
            }
            
        }
    }
}
