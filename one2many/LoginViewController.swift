//
//  LoginController.swift
//  one2many
//
//  Created by Tung Ly on 2/12/16.
//  Copyright © 2016 one2many. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //already logged in
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("LoggedInUserView", sender: nil)
            //print("hello mate")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loginErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func login(sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        if email != "" && password != "" {
            
            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
                } else {
                    
                    // store uid
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // switch scene
                    self.performSegueWithIdentifier("LoggedInUserView", sender: nil)
                    print("hello")
                }
            })
            
        } else {
            
            loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
        }
    }
}
