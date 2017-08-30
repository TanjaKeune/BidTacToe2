//
//  BidViewController.swift
//  TicTacToe
//
//  Created by Tanja Keune on 5/29/17.
//  Copyright © 2017 Tanja Keune. All rights reserved.
//

import UIKit

class BidViewController: UIViewController {

    @IBOutlet weak var soreLeft: UILabel!
    
    @IBOutlet weak var soreRight: UILabel!
    
    @IBOutlet var bidTextField: UITextField!
    
    @IBOutlet var playerOLabel: UILabel!
    
    @IBOutlet var playerOPoints: UILabel!
    
    @IBOutlet var playerXPoints: UILabel!
    
    @IBOutlet var bid: UIButton!
    
    @IBOutlet var playerTurnImage: UIImageView!
    
    @IBOutlet var PlayerOImage: UIImageView!
    @IBOutlet var PlayerXImage: UIImageView!
    
    var activePlayer = 1 // 1 - noughts, 2 - crosses
    
    var playerX = 100
    var playerO = 100
    
    var scoreL = 0
    var scoreR = 0
    
    var resetCredits = false
    
    var xBid = 0
    var oBid = 0
    var sum = 0
    
    var player1 = 0
    
    var gameStateSaved = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var sendPlayer = 0
    
    var x = 0 // 0 - didn't place a bid, 1- did placed bid
    
    var o = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(player1)
        
        //playerTurnLabel.text = "Player O turn. Make your bid:"
//        if activePlayer == 1 {
            playerTurnImage.image = UIImage(named: "oMakeBid2.png")
//        } else {
//            playerTurnImage.image = UIImage(named: "xMakeBid2.png")
//        }
        print(gameStateSaved)
        if resetCredits == true {
            playerX = 100
            playerO = 100
        }
        
        playerOPoints.text = String(playerO)
        playerXPoints.text = String(playerX)
        
        soreLeft.text = String(scoreL)
        soreRight.text = String(scoreR)
        
        PlayerOImage.image = UIImage(named: "PlayerO.png")
        PlayerXImage.image = UIImage(named: "PlayerX.png")
        //put a logo on navigation bar
        
        let logo = UIImage(named: "smallerBidLogo.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        //set color to navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 79.0/255.0, green: 147.0/255.0, blue: 218.0/255.0, alpha: 1.0 )
        
        //set background color to view
        
        self.view.backgroundColor = UIColor(red: 245.0/255.0, green: 233.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        //puts a navigation background image but has to be right size
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bidButtonPressed(_ sender: AnyObject) {
      
        
        
        let bidCurrent = Int(bidTextField.text!)!
 
        if activePlayer == 1 {
        
            //is noughts player
            
            if bidCurrent <= playerO {
                
                oBid = bidCurrent
                
                playerO -= oBid
                
                o = 1
                
               // playerTurnLabel.textColor = UIColor.red
               // playerTurnLabel.text = "Player X turn. Make your bid:"
                
                playerTurnImage.image = UIImage(named: "xMakeBid2.png")
                bidTextField.text = ""
                activePlayer = 2
                
            } else {
                
                //message "Not suffisant funds, you have \(playerO) pints."
                self.alertMessageOk(title: "Don't have enugh credits.", message: "Please check you credits and bid again.")
            }
            
      } else {
            
            //Crosses turn
            
            if bidCurrent <= playerX {
                
                xBid = bidCurrent
                
                playerX -= xBid
                
                x = 1
                
               // playerTurnLabel.text = "Plaer Noughts turn. Make your bid:"
                
                activePlayer = 1

                // check who won
                //
                if o == 1 && x == 1 {
                    
                    o = 0
                    x = 0
                    
                    if xBid > oBid {
                        
                        playerTurnImage.image = UIImage(named: "xMakeBid2.png")
                        bidTextField.isHidden = true
                        playerO += xBid + oBid
                        //won call segue to the board
                        
                        sendPlayer = 2
                        print(sendPlayer)
                        performSegue(withIdentifier: "play", sender: sendPlayer)  //2
                        
                    } else if xBid == oBid {
                        
                        //add alert to tell them they had equal bids so they should go again
                        
                        playerX += xBid
                        playerO += oBid
                        playerTurnImage.image = UIImage(named: "oMakeBid2.png")
                        bidTextField.text = ""
                        
                        alertMessageOk(title: "Bids matched!", message: "Try again")
                        
                    } else {
                        
//                        playerTurnImage.image = UIImage(named: "checkPoints.png")
                        bidTextField.isHidden = true
                        playerX += xBid + oBid
                        //won call segue to the board
                        
                        sendPlayer = 1
                        print(sendPlayer)
                        performSegue(withIdentifier: "play", sender: sendPlayer)  //1
                        
                    }
                    playerXPoints.text = String(playerX)
                    playerOPoints.text = String(playerO)
                    bidTextField.isHidden = false

                }
            }
            
            else {
                
                    self.alertMessageOk(title: "Don't have enugh credits for the bid", message: "Please check you credits and place new bid")

            }
            
        
    
    
    }

}
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "play" {
            
            let destination = segue.destination as! ViewController
                
            destination.player = sendPlayer
            destination.gameState = gameStateSaved
            destination.playerOPoints = playerO
            destination.playerXPoints = playerX
            destination.complitedTurn = false
            destination.scoreR = scoreR
            destination.scoreL = scoreL
            
        }
    }
}
