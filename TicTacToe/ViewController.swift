//
//  ViewController.swift
//  TicTacToe
//
//  Created by Tanja Keune on 5/29/17.
//  Copyright © 2017 Tanja Keune. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winningImage: UIImageView!
    
    @IBOutlet var playAgainButton: UIButton!
    
    @IBOutlet var button: UIButton!
    
    //1 is noughts, 2 is cross
    
    var player = 0 // 0 - no player 1 - noughts, 2 - crosses
    
    var playerOPoints = Int()
    
    var playerXPoints = Int()
    
    var scoreL = 0
    var scoreR = 0
    
    var resetCredits = false
    
    @IBOutlet var logoView: UIImageView!
    
    var activeGame = true
    
    var complitedTurn = false
    
    
    
    var winningCombitnation = [[2, 4, 6], [0,4,8], [0, 1, 2], [0,3,6], [1, 4, 7], [2, 5 , 8], [3, 4, 5], [6, 7, 8]]
    
    var gameState = [Int](repeatElement(0, count: 9))  // 0 - empty, 1 -noughts, 2 - crosses
    
    override func viewWillAppear(_ animated: Bool) {
        
//        Present WinningImage with players turn
        
        if player == 1 {
            winningImage.alpha = 1
            winningImage.image = UIImage(named: "OTurn.png")
            UIView.animate(withDuration: 0.5) {
                
                self.winningImage.center = CGPoint(x: self.winningImage.center.x + 500, y: self.winningImage.center.y)
            }
            
//            (winningImageTakeAWay())
            self.perform(#selector(winningImageTakeAWay), with: nil, afterDelay: 1.0)
            
        } else {
            winningImage.alpha = 1
            winningImage.image = UIImage(named: "XTurn.png")
            UIView.animate(withDuration: 0.5) {
                
                self.winningImage.center = CGPoint(x: self.winningImage.center.x + 500, y: self.winningImage.center.y)
            }
            
//            winningImageTakeAWay()
            self.perform(#selector(winningImageTakeAWay), with: nil, afterDelay: 1.0)

        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        set button size
        let screenWidth = UIScreen.main.bounds.width
        
        winningImage.alpha = 0
        winningImage.center = CGPoint(x: winningImage.center.x - 500, y: winningImage.center.y)
        
        
        winningImage.frame.size = CGSize(width: screenWidth * 4 / 3, height: screenWidth * 4 / 3)
        
        let buttonSize = (screenWidth - 30) / 3
        
        for i in 1 ... 9 {
            
            button = self.view.viewWithTag(i) as! UIButton
            
            button.frame.size = CGSize(width: buttonSize, height: buttonSize)
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        playAgainButton.isHidden = true
        
        //hides the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //sets background color on view controller
        self.view.backgroundColor = UIColor(red: 245.0/255.0, green: 233.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        
        for i in 1...9 {
            
            button = self.view.viewWithTag(i) as! UIButton!
            if gameState[i-1] == 1 {
                
                button.setImage(UIImage(named: "noughts.png"), for: [])
                
            } else if gameState[i-1] == 2 {
                
                button.setImage(UIImage(named: "crosses.png"), for: [])
                
            }
        }
        
        logoView.image = UIImage(named: "smallerBidLogo.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonPressed(_ sender: AnyObject) {
        
        if !complitedTurn {

        let activePosition = sender.tag - 1
        
//            Place the move if the spot is empty and we have an active game
            
        if gameState[activePosition] == 0 && activeGame {
            
            if player == 1 {
                
                sender.setImage(UIImage(named: "noughts.png"), for: [])
                
                player = 2
                
                gameState[activePosition] = 1
                
            } else {
                
                sender.setImage(UIImage(named: "crosses.png"), for: [])
                
                player = 1
                
                gameState[activePosition] = 2
            }
        }
        
//            after you place the move check for winning Combination
            
        for combination in winningCombitnation {
            
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                
                // we have a winner
                activeGame = false
                playAgainButton.isHidden = false
                
                switch gameState[combination[0]] {
                case 1:
                    winningImage.alpha = 1
                    winningImage.image = UIImage(named: "GroupO.png")
                    
                    scoreL += 1
                    
                    UIView.animate(withDuration: 0.5) {
                        
                        self.winningImage.center = CGPoint(x: self.winningImage.center.x + 500, y: self.winningImage.center.y)
                    }
                    
                case 2:
                    
                    winningImage.alpha = 1
                   
                    winningImage.image = UIImage(named: "GroupX.png")

                    scoreR += 1
                    
                    UIView.animate(withDuration: 0.5) {
                        
                        self.winningImage.center = CGPoint(x: self.winningImage.center.x + 500, y: self.winningImage.center.y)
                    }

                default:
                    return
                }
                
                //clean the board and
                resetCredits = true
                gameState = [Int](repeatElement(0, count: 9))
                
            } else {
                var tie = true
                for state in gameState {
                    if state == 0 {
                        tie = false
                    }
                }
                if tie == true {
                    self.activeGame = false
                    //self.winLabel.isHidden = false
                    self.alertMessageOk(title: "This game is tied", message: "Try again")
                    //self.winLabel.text = "This game is tied!"
                    self.playAgainButton.isHidden = false
                }
            }
        }
        complitedTurn = true
            
        }
        
        if complitedTurn && activeGame {
            
            self.perform(#selector(callSegue), with: nil, afterDelay: 2.0)

        }
    }
    
    func callSegue() {
        
        performSegue(withIdentifier: "goBid", sender: nil)
    }
    
    @IBAction func playAgain(_ sender: AnyObject) {
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        activeGame = true
        
        player = 1
        
        for i in 1 ..< 10 {
            
            if let button = view.viewWithTag(i) as? UIButton {
                
                button.setImage(nil, for: [])
            }
            
        }
        playAgainButton.isHidden = true
        performSegue(withIdentifier: "goBid", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "goBid" {
            
            if let navVC = segue.destination as? UINavigationController {
                
                if let destination = navVC.topViewController as? BidViewController {
                    
                    destination.gameStateSaved = gameState
                    destination.playerX = playerXPoints
                    destination.playerO = playerOPoints
                    destination.resetCredits = resetCredits
                    destination.scoreL = scoreL
                    destination.scoreR = scoreR
                    
                    
                }
            }
        }
        
        
    }
    
// winning image disapear
    
    func winningImageTakeAWay() {
        
        UIView.animate(withDuration: 0.5) {
         
            self.winningImage.center = CGPoint(x: self.winningImage.center.x - 500, y: self.winningImage.center.y)
            
        }
        winningImage.alpha = 0
    }
    
    
}

