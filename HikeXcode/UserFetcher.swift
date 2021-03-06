//
//  UserFetcher.swift
//  HikeXcode
//
//  Created by 今村翔一 on 2015/11/19.
//  Copyright © 2015年 今村翔一. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserFetcher: UIViewController {
    
    let baseURL = URL.Login.Auth.getURL()
    private var defaultParameter:[String:String] = [:]
    var setParameter:[String:String] {
        get {
            return defaultParameter
        }
        set(params) {
            self.defaultParameter = params
        }
    }
    
    func download(callback:(User)->Void){
        Alamofire.request(.GET, baseURL, parameters: defaultParameter).responseJSON {_, _, result in
            if result.isSuccess,
                let res = result.value as? [String:AnyObject]{
                    print("userData:\(res)")
                    //userData:["id": 1, "result": 1, "username": ShoichiImamura]
                    //trueなら1, falseなら0になっている
                    if res["result"]!.integerValue == 1 {
                        let userData = User(json: JSON(res))
                        callback(userData)
                    }
            }
        }
    }
}
