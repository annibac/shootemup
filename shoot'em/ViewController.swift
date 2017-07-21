//
//  ViewController.swift
//  shoot'em
//
//  Created by etna on 18/07/2017.
//  Copyright © 2017 etna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bird: UIImageView!
    
    var timer: Timer!
    var timerSprite: Timer!
    var imagePos: Int = 0
    
    @IBOutlet weak var spriteChar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerSprite = Timer.scheduledTimer(timeInterval: 0.13, target: self, selector: #selector(changeImg), userInfo: nil, repeats: true)
    }


    @IBAction func moveButtonTUI(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func moveButtonTD(_ sender: UIButton) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (t:Timer) in
            if sender.tag == 0{
            self.bird.center.x = self.bird.center.x - 10
        }else{
            self.bird.center.x = self.bird.center.x + 10
            }
        })
    }
    
    func changeImg()
    {
        
        spriteChar.image = UIImage(named: "\(imagePos).png")
        if(imagePos >= 0 && imagePos != 5){
            imagePos += 1;
        }
        else
        {
            imagePos = 0;
        }
    }
    
}

