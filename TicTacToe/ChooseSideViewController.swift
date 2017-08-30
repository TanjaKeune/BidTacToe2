//
//  ChooseSideViewController.swift
//  TicTacToe
//
//  Created by Tanja Keune on 8/29/17.
//  Copyright © 2017 Tanja Keune. All rights reserved.
//

import UIKit

class ChooseSideViewController: UIViewController {
    
    var player = 0 // 1 - noughts, 2 - crosses

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "chooseSide" {
            
            let destination = segue.destination as! BidViewController
            
            destination.activePlayer = player
            
        }
        
        
    }
    
    @IBAction func CrossesButton(_ sender: Any) {
        
        player = 2
    }

    @IBAction func NoughtsButton(_ sender: Any) {
        
        player = 1
        
    }
}
