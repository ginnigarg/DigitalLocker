//
//  RegisterViewController.swift
//  DigitalLocker
//
//  Created by Guneet Garg on 17/05/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var userNameTextField : UITextField!
    @IBOutlet weak var userEmailTextField : UITextField!
    @IBOutlet weak var userPasswordTextField : UITextField!
    @IBOutlet weak var userCnfPasswordTextField : UITextField!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    var name : String = ""
    var email : String = ""
    var pwd : String = ""
    var cnfPwd : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        empty ()
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    @IBAction func cancel () {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register (_ sender : Any) {
        fetchText ()
        if name == "" || email == "" || pwd == "" || cnfPwd == "" {
            displayAlert (message: " All Text Field compulsory !!! ")
            empty ()
            return
        } else if cnfPwd == pwd {
            changeState(activityindicator: activityIndicator)
            print (email)
            print (pwd)
            Auth.auth().createUser(withEmail : email , password : pwd, completion: { (user , error) in
                print (user ?? "User")
                print (error ?? "Error")
                if error == nil {
                    print ("No Error In Creating User")
                    let userName = Auth.auth().currentUser?.createProfileChangeRequest ()
                    userName?.displayName = self.name
                    userName?.commitChanges(completion: { error in
                        print ("Commited Changes")
                        if error == nil {
                            print ("Nil Error After Commit")
                            self.changeState(activityindicator: self.activityIndicator)
                            let newController = self.storyboard?.instantiateViewController (withIdentifier: "LoginViewController") as! LoginViewController
                            self.present (newController , animated : true, completion : nil)
                            self.displayAlert (message: " Registration Successfull !!! ")
                            self.empty ()
                        }
                    })
                } else {
                    self.changeState(activityindicator: self.activityIndicator)
                    self.displayAlert (message: " Registration Failed. Please Try Again Later !!! ")
                }
            })
            return
        } else {
            displayAlert (message: " Password Did Not Match !!! ")
            empty ()
            changeState(activityindicator: activityIndicator)
            return
        }
    }
    
    func fetchText () {
        name = userNameTextField.text!
        email = userEmailTextField.text!
        pwd = userPasswordTextField.text!
        cnfPwd = userCnfPasswordTextField.text!
    }
    
    func empty () {
        name = ""
        email = ""
        pwd = ""
        cnfPwd = ""
        userNameTextField.text = ""
        userEmailTextField.text = ""
        userPasswordTextField.text = ""
        userCnfPasswordTextField.text = ""
    }
    
}
