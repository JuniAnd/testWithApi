//
//  RequestHelper.swift
//  testWithAPI
//
//  Created by 15k on 29.03.18.
//  Copyright © 2018 15k. All rights reserved.
//

import Foundation
import Alamofire

class RequestHelper {
    
    var accessToken: String?
    
    static let shared: RequestHelper = {
        let instance = RequestHelper()
        return instance
    }()
    
    func login(email: String?, password: String?, complition: @escaping ()->Void) {
        
        guard let loginEmail = email, let loginPassword = password else { return }
        
        Alamofire.request("http://apiecho.cf/api/login/", method: .post, parameters: ["email":loginEmail,"password":loginPassword]).responseJSON { [weak self]response in
            
            let responseInfo = response.result.value as? [String : AnyObject]

            if responseInfo?["success"] as? Bool ?? false {
                guard let token = responseInfo?["data"]?["access_token"] as? String else { return }
                self?.accessToken = token
                complition()
            } else {
                var errorMessage = ""
                let arrayErrors = responseInfo?["errors"] as? [[String: Any]]
                if let value = arrayErrors {
                    for i in value  {
                    errorMessage += "\(i["message"] ?? "") \n"
                    }
                }
                self?.errorAlert(messageStr: errorMessage)
            }
        }
    }
    
    func signup(name: String?, email: String?, password: String?, complition: @escaping ()->Void) {
    
        guard let signupName = name, let signupEmail = email, let signupPassword = password else { return }
        
        Alamofire.request("http://apiecho.cf/api/signup/", method: .post, parameters: ["name":signupName,"email":signupEmail,"password":signupPassword]).responseJSON { [weak self] response in
            
            let responseInfo = response.result.value as? [String : AnyObject]
            
            if responseInfo?["success"] as? Bool ?? false {
                guard let token = responseInfo?["data"]?["access_token"] as? String else {return}
                self?.accessToken = token
                complition()
            } else {
                var errorMessage = ""
                let arrayErrors = responseInfo?["errors"] as? [[String: Any]]
                if let value = arrayErrors {
                    for i in value  {
                        errorMessage += "\(i["message"] ?? "") \n" 
                    }
                }
                self?.errorAlert(messageStr: errorMessage)
                errorMessage = ""
            }
        }

    }
    
    func getTextRequest(complition: @escaping (String)->Void) {
        
        if let token = self.accessToken {
            
        Alamofire.request("http://apiecho.cf/api/get/text/", parameters: ["Locale":"en_US"], headers: ["Authorization" : "Bearer \(token)"]).responseJSON { resp in
            
            let responseData = resp.result.value as? [String : AnyObject]
            complition(responseData?["data"] as?  String ?? "")
            }
        } else {
            print("Request without access token, error code - 401")
        }
    }
    
    func errorAlert(messageStr: String) {
        
        let alert = UIAlertController(title: "Error", message: messageStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let navContr = appDelegate.window?.rootViewController as? UINavigationController {
                if let vc = navContr.viewControllers.last {
                    vc.present(alert,animated: true,completion: nil)
                }
            }
        }
    }
    
}







