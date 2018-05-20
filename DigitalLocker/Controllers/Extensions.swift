//
//  Extensions.swift
//  DigitalLocker
//
//  Created by Guneet Garg on 17/05/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIViewController {
    
    func displayAlert (message : String) {
        let alert = UIAlertController (title:"Alert", message : message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction (title:"OK", style:UIAlertActionStyle.default, handler:nil)
        alert.addAction (action)
        self.present (alert, animated:true, completion:nil)
    }
    
    func changeState (activityindicator : UIActivityIndicatorView) {
        activityindicator.isHidden = !activityindicator.isHidden
        if activityindicator.isAnimating {
            activityindicator.stopAnimating ()
        } else {
            activityindicator.startAnimating ()
        }
    }
}
