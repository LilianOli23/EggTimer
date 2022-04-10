//
//  ViewController.swift
//  EggTimerStartStop
//
//  Created by Lilian De Oliveira Silva on 10/04/22.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let eggTimes = ["Soft": 180, "Medium": 240, "Hard": 420]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
           
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!//soft, medium, hard
        
        titleLabel.text = hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @IBAction func startStopTapped(_ sender: Any) {
            if(timerCounting) {
                timerCounting = false
                timer.invalidate()
                startStopButton.setTitle("START", for: .normal)
                startStopButton.setTitleColor(UIColor.green, for: .normal)
                
            } else {
                timerCounting = true
                startStopButton.setTitle("STOP", for: .normal)
                startStopButton.setTitleColor(UIColor.red, for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            }
        }

    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
}
