//
//  TableViewController.swift
//  DigitalLocker
//
//  Created by Guneet Garg on 17/05/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TableViewController : UITableViewController {
    
    @IBOutlet weak var notesTableView : UITableView!
    var data : String = ""
    var databaseRef : DatabaseReference!
    var databaseHandler : DatabaseHandle!
    var notes : [DataSnapshot]! = []
    var username = Auth.auth().currentUser?.displayName
    var userId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        databaseRef = Database.database().reference()
        createHandler ()
    }
    
    func createHandler () {
        print("Create Handler Function called")
        databaseHandler = databaseRef.child("users").child(username!).observe(.childAdded , with : { (dataSnapshot : DataSnapshot) in
            print("Insdide the handler")
            print(dataSnapshot)
            Constants.notes = []
            Constants.notes.append ((dataSnapshot.value as? String)!)
            self.notes.append (dataSnapshot)
            self.notesTableView.insertRows (at: [IndexPath(row: self.notes.count-1,section: 0)], with: .automatic)
            self.notesTableView.reloadData ()
        })
        //print("Insdide the handler")
    }
    
    @IBAction func add (_ sender : Any) {
        let newController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        //self.performSegue(withIdentifier: "addNewNote", sender: self)
        self.present(newController, animated : true, completion: nil)
    }
    
    @IBAction func logOut (_ sender : Any) {
        try? Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView (_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return notes.count
    }
    
    override func tableView (_ tableView: UITableView, cellForRowAt index : IndexPath) -> UITableViewCell {
        let tableCell : UITableViewCell! = notesTableView.dequeueReusableCell (withIdentifier: "notes", for: index)
        databaseRef.child("users").child(username!).observe(.childAdded, with: { noteSnapshot in
            //print (noteSnapshot.value!)
            tableCell.textLabel?.text = (self.notes[index.row].value as? String)
        })
        
        return tableCell!
    }
    
}
