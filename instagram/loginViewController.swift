//
//  loginViewController.swift
//  instagram
//
//  Created by Ekko Lin on 3/12/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignin(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user, error) in
            if user != nil {
                print("Successfully login")
                self.performSegue(withIdentifier: "instagramNavigationController", sender: nil)
            } else {
                print("Cannot login. Please try again")
            }
        }
    }
    
    
    @IBAction func onSignup(_ sender: UIButton)
    {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successfully register")
                self.performSegue(withIdentifier: "instagramNavigationController", sender: nil)
            }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
