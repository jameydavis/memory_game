//
//  LobbyViewController.swift
//  Memory Game
//
//  Created by Jamey Davis on 3/18/19.
//  Copyright © 2019 Jamey Davis. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    @IBOutlet var gridSizeButtons: [UIButton]!
    
    let defaults = UserDefaults.standard
    let cornerRadiusPercentage: CGFloat = 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundButtonCorners()
        
        // Do any additional setup after loading the view.
    }
    
    func roundButtonCorners() {
        for button in self.gridSizeButtons {
            button.layer.cornerRadius = button.frame.height * cornerRadiusPercentage
        }
    }
    
    @IBAction func threeByFourTapped(_ sender: Any) {
        defaults.set(3, forKey: "NumberOfColumns")
        defaults.set(12, forKey: "NumberOfCards")
        defaults.set(6, forKey: "PairsMultiplier")
        self.performSegue(withIdentifier: "playGame", sender: self)
    }

    @IBAction func fiveByTwoTapped(_ sender: Any) {
        defaults.set(5, forKey: "NumberOfColumns")
        defaults.set(10, forKey: "NumberOfCards")
        defaults.set(5, forKey: "PairsMultiplier")
        self.performSegue(withIdentifier: "playGame", sender: self)
    }
    
    @IBAction func fourByFourTapped(_ sender: Any) {
        defaults.set(4, forKey: "NumberOfColumns")
        defaults.set(16, forKey: "NumberOfCards")
        defaults.set(8, forKey: "PairsMultiplier")
        self.performSegue(withIdentifier: "playGame", sender: self)
    }
    
    @IBAction func fourByFiveTapped(_ sender: Any) {
        defaults.set(4, forKey: "NumberOfColumns")
        defaults.set(20, forKey: "NumberOfCards")
        defaults.set(10, forKey: "PairsMultiplier")
        self.performSegue(withIdentifier: "playGame", sender: self)
    }
}
