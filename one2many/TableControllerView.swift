//  TableControllerView.swift
//  one2many
//
//  Created by Tung Ly on 2/11/16.
//  Copyright © 2016 one2many. All rights reserved.
//

import UIKit

class TableControllerView: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var This_Is_Label: UILabel!
    
    
    
    let ref = Firebase(url: "https://test-swift-js.firebaseio.com/")
    
    
    
    let members = [
        ("mohamed gaggutur", "architect"),
        ("nikko lee", "developer"),
        ("tung ly", "party planner"),
        ("casey thavy", "stripper")
    ]
    
    
    //Starting point here
    override func viewDidLoad() {
        super.viewDidLoad()
        //when this screen first loads, it goes to fb and looks up the value either "one" or "two" and assign it to [This_Is_Label]
        ref.observeEventType (.Value, withBlock: { snapshot in
            self.This_Is_Label.text = snapshot.value as? String
        })
    }
    
    
    // **** BUTTON ACTION LISTENER HERE *******
    
    //Everytime [one] or [two] is clicked, data in fb changes
    //this function is created by ctr click on an object and drag
    //it over to this file
    @IBAction func updateOneTwo(sender: UIButton) {
        ref.setValue(sender.titleLabel?.text)
    }
    
    
    //how many sections in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //how many rows in table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    //populate content
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell() // empty cell
        let (name, role) = members[indexPath.row]
        cell.textLabel?.text = name + " | " + role
        return cell
    }
    
    
    // IGNORE this func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    

    
    
}

