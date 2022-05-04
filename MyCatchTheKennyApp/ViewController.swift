//
//  ViewController.swift
//  MyCatchTheKennyApp
//
//  Created by Toygun Çil on 3.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var kennyArray = [UIImageView]()
    var visTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stHS = UserDefaults.standard.object(forKey: "highscore")
        if stHS == nil {
            highScore = 0
            highscoreLabel.text = "High Score: 0"
        }
        if let newSc = stHS as? Int{
            highScore = newSc
            highscoreLabel.text = "High Score: \(highScore)"
        }
        
        scoreLabel.text = "Score: \(score)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRec1 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec2 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec3 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec4 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec5 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec6 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec7 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec8 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        let gestureRec9 = UITapGestureRecognizer(target: self, action: #selector(scoreCounter))
        
        kenny1.addGestureRecognizer(gestureRec1)
        kenny2.addGestureRecognizer(gestureRec2)
        kenny3.addGestureRecognizer(gestureRec3)
        kenny4.addGestureRecognizer(gestureRec4)
        kenny5.addGestureRecognizer(gestureRec5)
        kenny6.addGestureRecognizer(gestureRec6)
        kenny7.addGestureRecognizer(gestureRec7)
        kenny8.addGestureRecognizer(gestureRec8)
        kenny9.addGestureRecognizer(gestureRec9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7, kenny8,kenny9]
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        visTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(visKenny), userInfo: nil, repeats: true)
        
        visKenny()
    }
    
    @objc func timerFunction() {
        timeLabel.text = String(counter)
        counter -= 1
        if counter == 0 {
            timer.invalidate() // timer durdurma
            visTimer.invalidate()
            timeLabel.text = "0"
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score
                highscoreLabel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
            let repButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in 
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.visTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.visKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(repButton)
            self.present(alert, animated: true, completion: nil)
        
            visKenny()
        }
    }
    
    @objc func scoreCounter(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func visKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let randomInt = Int(arc4random_uniform(UInt32(kennyArray.count - 1 )))
        kennyArray[randomInt].isHidden = false
    }
}

