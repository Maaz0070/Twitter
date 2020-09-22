//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Maaz Adil on 9/14/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]() //start with empty dictionariy
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl() //when pull up refresh

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets() //when view loads call the loadTweet finction
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)  //when it loads first also want to do this. Target we want refresh to happen on this screen. Selector we want to print tweets again.
        tableView.refreshControl = myRefreshControl //Telling table which refresh control to use

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadMoreTweets()
    }// load tweets when view appears instead of just load once. To call it everytime
    
    @objc func loadTweets(){
        
        numberOfTweet = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweet]//
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in //when sucess NSDictionary repsonse we will call it tweets so when we write our code we can refer to reuslt as tweets and we will store the tweets in local array
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)  //storing tweets in tweet array
                self.myRefreshControl.endRefreshing()//after updating table end the refreshing
            }
             self.tableView.reloadData() //make sure anytime we call the API, we repopulate our list to reload data with that content
        }, failure: { (Error) in
            print("Could not retreive tweets! oh no!")
        })//call AP
    }
    
    
    
    //Function adds twenty tweets adds +10 as they score
    func loadMoreTweets()
    {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json" //same API call
        //change the way we are setting count. Inst
        numberOfTweet = numberOfTweet + 20//Whatever the number of tweet is at this point add20 tweets on top of that
        let myParams = ["count": numberOfTweet]
        
        //same API call as before and what to do when succeed and what to do when fail
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in //when sucess NSDictionary repsonse we will call it tweets so when we write our code we can refer to reuslt as tweets and we will store the tweets in local array
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)  //storing tweets in tweet array
                self.myRefreshControl.endRefreshing()//after updating table end the refreshing
            }
             self.tableView.reloadData() //make sure anytime we call the API, we repopulate our list to reload data with that content
        }, failure: { (Error) in
            print("Could not retreive tweets! oh no!")
        })//call AP
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count {
        loadMoreTweets()
        }
    }//need to trigger loadMoreTweest when user gets to end of page
    

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil) //screen will dismiss. Want it to be animated. Don't want anything to happen once it's gone.
        UserDefaults.standard.set(false, forKey: "userLoggedIn") //set value for userLoggein to false so next time it asks you to log in 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
            //deciding what labels will display
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String//in user dictinary we are getting name
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as! String //gets tweet at specific index of array of tweets. texts is what the API refers to tweets
        //identifier of tweet cell is set to our identifier of the table view cell
        //exclamation mark forces it to be of type TweetCellTableViewCell
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //just have 1 section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count//return amount of teets fetched from API
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
