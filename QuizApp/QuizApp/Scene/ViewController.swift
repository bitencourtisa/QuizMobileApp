//
//  ViewController.swift
//  QuizApp
//
//  Created by isabella.bitencourt on 28/01/20.
//  Copyright © 2020 isabella.bitencourt. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol: class {
    func updateList(word: String)
    func displayQuestion(question: String)
}

class ViewController: UIViewController, ViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var interactor: InteractorProtocol?
    var words: [String] = []
    var seconds = 300
    var timer = Timer()
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countAuxiliar: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var insertWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = Interactor(presenter: Presenter(viewController: self))
        tableView.register(WordsTableViewCell.self, forCellReuseIdentifier: "answerList")
        tableView.delegate = self
        tableView.dataSource = self
        insertWordTextField.delegate = self
        insertWordTextField.resignFirstResponder()
        
    }
    
    func updateList(word: String) {
        if !words.contains(word) {
            words.append(word)
        }
        updateCounter()
        tableView.reloadData()
    }
    
    func updateCounter() {
        countAuxiliar.text = "\(words.count) "
        if words.count == 50 {
            timer.invalidate()
            self.displayAlert(title: "Congratulations", message: "Good Job! You found all the answers on time. Keep up with the great work.", action: "Play Again")
        }
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func displayQuestion(question: String) {
        self.question.text = question
    }
    
    private func displayAlert(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { action in
            self.reset()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK -- Table View Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "answerList", for: indexPath) as? WordsTableViewCell {

            let label = UILabel()
            label.frame = CGRect(x: 10, y: 10, width: 160, height: 30)
            label.text = words[indexPath.row]
            cell.contentView.addSubview(label)
            
            return cell
            
        } else {
            fatalError()
        }
    }
    
    //MARK -- Timer
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds == 0 {
            timer.invalidate()
            self.displayAlert(title: "Time finished", message: "Sorry, time is up! You got \(words.count) of 50 answers", action: "Try Again")
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @IBAction func resetGameTapped(_ sender: UIButton) {
        startButton.isHidden = false
        resetButton.isHidden = true
        insertWordTextField.isEnabled = false
        reset()
    }
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        startButton.isHidden = true
        resetButton.isHidden = false
        insertWordTextField.isEnabled = true
        runTimer()
        
    }

    func reset() {
        timer.invalidate()
        seconds = 300
        timerLabel.text = timeString(time: TimeInterval(seconds))
        countAuxiliar.text = "00"
        words = []
        tableView.reloadData()
        
    }
    
    //MARK -- TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            insertWordTextField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        interactor?.checkWord(answer: textField.text ?? "")
        insertWordTextField.text = ""
        
    }
    
    @IBAction func wordsTextInput(_ sender: UITextField) {
        textFieldDidEndEditing(sender)
    }
}

