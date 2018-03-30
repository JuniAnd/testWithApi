//
//  ViewController.swift
//  testWithAPI
//
//  Created by 15k on 29.03.18.
//  Copyright © 2018 15k. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        RequestHelper.shared.login(email: loginEmail.text, password: loginPassword.text, complition: {
            RequestHelper.shared.getTextRequest(complition: { text in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Table") as? TableViewController
                vc?.getTextFromRequest = text
                self.navigationController?.pushViewController(vc!, animated: true)
            })
        })
    }
    
}

