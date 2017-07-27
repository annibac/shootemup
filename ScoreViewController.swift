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
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var totalScoreText: UILabel!
    var score: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreText.text = scoreText.text! + score
        totalScoreText.text = UserDefaults.standard.string(forKey: "SpidermanScores")
    }
    
    @IBAction func resetScores(_ sender: Any) {
        UserDefaults.standard.set("", forKey : "SpidermanScores")
        performSegue(withIdentifier: "ScoreToMenu", sender: nil)
    }
    
    @IBAction func saveScore(_ sender: Any) {
        if (nameText.text != nil ) {
            let defaults = UserDefaults.standard
            let pScore = defaults.string(forKey: "SpidermanScores")
            if (pScore != nil) {
                defaults.set(pScore! + nameText.text! + " : " + score + " ", forKey: "SpidermanScores")
            } else {
                defaults.set(nameText.text! + " : " + score + " ", forKey: "SpidermanScores")
            }
            performSegue(withIdentifier: "ScoreToMenu", sender: nil)
        }
    }
}
