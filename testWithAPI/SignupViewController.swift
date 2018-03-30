//
//  SignupViewController.swift
//  testWithAPI
//
//  Created by 15k on 29.03.18.
//  Copyright © 2018 15k. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {
    @IBOutlet weak var signupName: UITextField!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    
    @IBAction func signupAction(_ sender: Any) {
        
        RequestHelper.shared.signup(name: signupName.text, email: signupEmail.text, password: signupPassword.text, complition: {
            RequestHelper.shared.getTextRequest(complition: { text in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Table") as? TableViewController
                vc?.getTextFromRequest = text
                self.navigationController?.pushViewController(vc!, animated: true)
            })
        })
    }

}
