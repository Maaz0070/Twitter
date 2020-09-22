//
//  TweetViewController.swift
//  Twitter
//
//  Created by Maaz Adil on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()//take tweetTextView and its basically saying I can take text in so display keybaord and cursor shows up

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil) // dismiss controller when cancel is pressed and completion is nil because we dont want anything to happen after just want to dismiss it
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){ //CHecking to see if tweet field is empty because we dont want to call api in that case
        TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
        self.dismiss(animated: true, completion: nil) //tweet success nothing much to show so dismiss
        }, failure: { (error) in // In failiure we are printing and error posting tweet and pasting error object and displays the string version of it.
            print("Error posting tweet \(error)")
            self.dismiss(animated: true, completion: nil)//dismiss again
        
        })
    }
    else {
    self.dismiss(animated: true, completion: nil) //if text is empty we will dismiss
    }
} //tweet success nothing much to show so dismiss. Completion is nil dont want to do anything after. In failiure we are printing and error posting tweet and pasting error object and displays the string version of it.
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
