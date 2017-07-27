//
//  ScoreViewController.swift
//  shoot'em
//
//  Created by etna on 26/07/2017.
//  Copyright © 2017 etna. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreText: UILabel!
    var score: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreText.text = scoreText.text! + score
    }
}
