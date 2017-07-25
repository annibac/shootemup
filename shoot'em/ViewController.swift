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
    @IBOutlet weak var wall1: UIImageView!
    @IBOutlet weak var wall2: UIImageView!
    @IBOutlet weak var Enemy: UIImageView!
    
    var timer: Timer!
    var timerSprite: Timer!
    var imagePos: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerSprite = Timer.scheduledTimer(timeInterval: 0.13, target: self, selector: #selector(changeImg), userInfo: nil, repeats: true)
        attack()
        
        moveWalls(wall2)
        moveWalls(wall1)
        makeEnnemies(Enemy)
    }


    @IBAction func moveButtonTUI(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func moveButtonTD(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (t:Timer) in
            if (sender.tag == 0) {
                if (self.spriteChar.center.x - 10 > 0) {
                        self.spriteChar.center.x -= 10
                }
            } else {
                if (self.spriteChar.center.x + 10 < screenSize.width) {
                        self.spriteChar.center.x += 10
                }
            }
        })
    }
    
    func changeImg()
    {
        spriteChar.image = UIImage(named: "\(imagePos).png")
        if(imagePos >= 0 && imagePos != 5) {
            imagePos += 1;
        } else {
            imagePos = 0;
        }
    }
    
    private func attack() {
        let imageName = "spider.png"
        let image = UIImage(named: imageName)
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (_) in
                let imageView = UIImageView(image: image!)
                imageView.center.y = self.spriteChar.center.y
                imageView.center.x = self.spriteChar.center.x
            
                self.view.addSubview(imageView)
                self.throwSpider(img: imageView)
        }
    }
    
    private func throwSpider(img: UIImageView)
    {
        UIView.animate(withDuration: 0.5, animations: {
            img.center.y = self.view.frame.minY
        }, completion: { (true) in
                img.removeFromSuperview()
        })
    }
    
    private func moveWalls(_ img: UIImageView) {
        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear, animations: {
            if (img.tag == 0) {
                img.center.y = (self.view.frame.size.height / 2)
            } else if (img.tag == 1) {
                img.center.y = self.view.frame.size.height + self.view.frame.size.height / 2
            }
        }, completion: { (true) in
            if (img.tag == 0) {
                img.center.y = -(self.view.frame.size.height / 2)
            } else if (img.tag == 1) {
                img.center.y = self.view.frame.size.height / 2
            }
            self.moveWalls(img)
        })
    }
    
    private func makeEnnemies(_ img: UIImageView) {
        UIView.animate(withDuration: 4, delay: 0,
            options: .curveLinear, animations: {
            img.center.y = self.view.frame.size.height
        }, completion: { (true) in
            img.center.y = -10
            img.center.x = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.height)))
            self.makeEnnemies(img)
        })
    }
}

