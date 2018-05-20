//
//  AddViewController.swift
//  DigitalLocker
//
//  Created by Guneet Garg on 17/05/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddViewController : UIViewController {
    
    @IBOutlet weak var dataTextField : UITextView!
    
    var data : String = ""
    var databaseRef : DatabaseReference!
    var username = Auth.auth().currentUser?.displayName
    var userId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        empty ()
        databaseRef = Database.database().reference()
    }
    
    @IBAction func cancel () {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit (_ sender : Any) {
        fetchText ()
        if data == "" {
            displayAlert(message: " Please enter the data to append !!! ")
            empty ()
            return
        } else {
            Constants.userName = username!
            Constants.notes.append(data)
            print(Constants.notes)
            databaseRef.child("users").child(username!).setValue(Constants.notes)
            empty ()
            self.dismiss (animated: true, completion: nil)
        }
    }
    
    func fetchText () {
        data = dataTextField.text!
    }
    
    func empty () {
        data = ""
        dataTextField.text! = ""
    }
}
