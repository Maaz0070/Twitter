//
//  LoginViewController.swift
//  Twitter
//
//  Created by Maaz Adil on 9/14/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"

        
        TwitterAPICaller.client?.login(url: myUrl, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self) // connection of login to home is triggered.
        }, failure: { (Error) in
            print("Could not log in!")
        }) //CLosure - tell me which url you want me to call what u want me to do when it works and what to do when it doesnt work. A specific url we are hitting on twitter API for logging in
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
