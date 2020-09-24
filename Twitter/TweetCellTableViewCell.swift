//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Maaz Adil on 9/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
    }
        var favorited:Bool = false //inititally self favortied to false
        var tweetId:Int = -1
        
        func setFavorite(_ isFavorited:Bool){  //when we set a cell to be favorited
            favorited = isFavorited //we are going to sell favorited to match this isFavorite
            if (favorited){ //if it is favorited then set image to fav button
                favButton.setImage(UIImage(named:"redheart"), for: UIControl.State.normal)
            }
            else{
                favButton.setImage(UIImage(named:"grayheart"), for: UIControl.State.normal) //if not favorited we set it to gray
                
            }
        }
    
    //Also action because people are pressing
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
