//
//  alert.swift
//  TicTacToe
//
//  Created by Tanja Keune on 6/19/17.
//  Copyright © 2017 Tanja Keune. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func alertMessageOk(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
