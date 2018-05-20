//
//  LoginViewController.swift
//  DigitalLocker
//
//  Created by Guneet Garg on 17/05/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController : UIViewController {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var acticityIndicator : UIActivityIndicatorView!
    
    var email : String = ""
    var password : String = ""
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        acticityIndicator.isHidden = true
        acticityIndicator.stopAnimating()
        empty ()
    }
    
    @IBAction func submit (_ sender : Any) {
        fetchText()
        changeState(activityindicator: acticityIndicator)
        if email == "" && password == "" {
            displayAlert(message: " Both Text Fields Empty !!! ")
            empty ()
            changeState(activityindicator: acticityIndicator)
            return
        } else if email == "" {
            displayAlert(message: " Email Text Field is Empty !!! ")
            empty ()
            changeState(activityindicator: acticityIndicator)
            return
        } else if password == "" {
            displayAlert(message: " Password Text Field is Empty !!! ")
            empty ()
            changeState(activityindicator: acticityIndicator)
            return
        } else  {
            Auth.auth().signIn(withEmail : email, password : password, completion: { user,error in
                if error != nil {
                    self.displayAlert(message: " Invalid Credentials or Network issues !!! ")
                    self.empty ()
                    self.changeState(activityindicator: self.acticityIndicator)
                    return
                } else {
                    self.changeState(activityindicator: self.acticityIndicator)
                    self.performSegue(withIdentifier : "mainSegue" , sender: sender )
                }
            })
        }
    }
    
    @IBAction func register (_ sender : Any) {
        let newController  = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.present(newController, animated : true, completion : nil)
    }
    
    func fetchText () {
        email = emailTextField.text!
        password = passwordTextField.text!
    }
    
    func empty () {
        email = ""
        password = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
}
