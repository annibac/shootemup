//
//  ViewController.swift
//  shoot'em
//
//  Created by etna on 18/07/2017.
//  Copyright © 2017 etna. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var spriteChar: UIImageView!
    @IBOutlet weak var wall1: UIImageView!
    @IBOutlet weak var wall2: UIImageView!
    @IBOutlet weak var scoreButton: UIButton!
    
    var timer: Timer!
    var timerSprite: Timer!
    var imagePos: Int = 0
    var difficulty: Int = 1
    var enemies = [UIImageView]()
    var shots = [UIImageView]()
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerSprite = Timer.scheduledTimer(timeInterval: 0.19, target: self, selector: #selector(changeImg), userInfo: nil, repeats: true)
        scoreButton.isHidden = true
        
        attack()
        moveWalls(wall2)
        moveWalls(wall1)
        sendEnemies()
        timerSprite = Timer.scheduledTimer(timeInterval: 0.19, target: self, selector: #selector(collisons), userInfo: nil, repeats: true)
    }


    @IBAction func moveButtonTUI(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func moveButtonTD(_ sender: UIButton) {
        let screenSize = UIScreen.main.bounds
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (t:Timer) in
            if (sender.tag == 0) {
                if (self.spriteChar.center.x - 12 > 0) {
                    self.spriteChar.center.x -= 12
                }
            } else {
                if (self.spriteChar.center.x + 12 < screenSize.width) {
                    self.spriteChar.center.x += 12
                }
            }
        })
    }
    
    func changeImg() {
        spriteChar.image = UIImage(named: "\(imagePos).png")
        if(imagePos >= 0 && imagePos != 5) {
            imagePos += 1;
        } else {
            imagePos = 0;
        }
    }
    
    private func attack() {
        let imageName = "Spider_Web_Small.png"
        let image = UIImage(named: imageName)
        Timer.scheduledTimer(withTimeInterval: 0.55, repeats: true) { (_) in
                let imageView = UIImageView(image: image!)
                imageView.center.y = self.spriteChar.center.y - 20
                imageView.center.x = self.spriteChar.center.x
            
                self.view.addSubview(imageView)
                self.throwSpider(img: imageView)
        }
    }
    
    private func throwSpider(img: UIImageView) {
        shots.append(img)
        UIView.animate(withDuration: 1, animations: {
            img.center.y = self.view.frame.minY
        }, completion: { (true) in
            self.shots.remove(at: self.shots.index(of: img)!)
            img.removeFromSuperview()
        })
    }
    
    private func moveWalls(_ img: UIImageView) {
        UIView.animate(withDuration: 18, delay: 0, options: [.curveLinear], animations: {
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
    
    private func sendEnemies() {
        let imageName = "100.png"
        let image = UIImage(named: imageName)
        let t = TimeInterval(4 / (difficulty + 1))
        Timer.scheduledTimer(withTimeInterval: t, repeats: true) { (_) in
            let imageView = UIImageView(image: image!)
            imageView.center.y = -10
            imageView.center.x = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))
            
            self.view.addSubview(imageView)
            self.makeEnemy(imageView)
        }
    }
    
    private func makeEnemy(_ img: UIImageView) {
        enemies.append(img)
        UIView.animate(withDuration: 4, delay: 0,
            options: .curveLinear, animations: {
            img.center.y = self.view.frame.size.height + 30
            img.center.x = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))
        }, completion: { (true) in
            self.enemies.remove(at: self.enemies.index(of: img)!)
            img.removeFromSuperview()
        })
    }
    
    func collisons (){
        for enemy in enemies {
            for shot in shots {
                if(enemy.layer.presentation()?.frame.intersects((shot.layer.presentation()?.frame)!) == true){
                    score += 1
                    enemy.removeFromSuperview()
                }
            }
            if(enemy.layer.presentation()?.frame.intersects((spriteChar.layer.presentation()?.frame)!) == true){
                scoreButton.isHidden = false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue)
        if (segue.identifier == "GameToScore") {
            let v = segue.destination as! ScoreViewController
            v.score = String(score)
        }
    }
}


