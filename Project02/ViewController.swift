//
//  ViewController.swift
//  Project02
//
//  Created by Paul Willis on 29/06/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctFlagNumber = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctFlagNumber = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctFlagNumber].uppercased() + " | Score: \(score)"
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionsAsked += 1
        
        if sender.tag == correctFlagNumber {
            score += 1
            validateAnswer(correct: true, sender: sender)
        } else {
            validateAnswer(correct: false, sender: sender)
        }
    }
    
    func validateAnswer(correct: Bool, sender: UIButton) {
        
        if questionsAsked == 10 {
            let ac = UIAlertController(title: "Round Ended", message: "Your final score is \(score) out of \(questionsAsked)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Finish", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            questionsAsked = 0
        } else if correct == true {
            correctAnswer()
        } else {
            wrongAnswer(sender: sender)
        }
    }
    
    func correctAnswer() {
        let ac = UIAlertController(title: "Correct", message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    func wrongAnswer(sender: UIButton) {
        let ac = UIAlertController(title: "Incorrect", message: "This is the flag of: \n\(countries[sender.tag].uppercased())", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
}

