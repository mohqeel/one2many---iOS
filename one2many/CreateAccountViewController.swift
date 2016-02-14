//
//  CreateAccountViewController.swift
//  one2many
//
//  Created by Tung Ly on 2/12/16.
//  Copyright © 2016 one2many. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func signupErrorAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func register(sender: UIButton) {
        
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" {
            
            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    
                } else {
                    
                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                        err, authData in
                        
                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
                        
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                    })
                    
                    // Store the uid
                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                    
                    // success -> go to another scene
                    self.performSegueWithIdentifier("LogInNewUser", sender: nil)
                    print("booya")
                }
            })
            
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
        }
        
    }
}