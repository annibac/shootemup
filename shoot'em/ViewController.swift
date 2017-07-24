//
//  ViewController.swift
//  shoot'em
//
//  Created by etna on 18/07/2017.
//  Copyright © 2017 etna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spiderman: UIImageView!
    @IBOutlet weak var spriteChar: UIImageView!
    @IBOutlet weak var spiders: UIImageView!
    
    var timer: Timer!
    var timerSprite: Timer!
    var imagePos: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerSprite = Timer.scheduledTimer(timeInterval: 0.17, target: self, selector: #selector(changeImg), userInfo: nil, repeats: true)
        throwSpiders(img: spiders)
    }


    @IBAction func moveButtonTUI(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func moveButtonTD(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (t:Timer) in
            if sender.tag == 0{
                if (self.spriteChar.center.x - 10 > 0) {
                        self.spriteChar.center.x -= 10
                }
            }else{
                if (self.spriteChar.center.x + 10 < screenSize.width) {
                        self.spriteChar.center.x += 10
                }
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
    
    private func throwSpiders(img: UIImageView)
    {
        UIView.animate(withDuration: 1, animations: {
            img.center.y = self.view.frame.minY},
                       completion: { (true) in
                        img.center.y = self.spriteChar.center.y
                        img.center.x = self.spriteChar.center.x
                        self.throwSpiders(img: img)
        })
    }
    
}

