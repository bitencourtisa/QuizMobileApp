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

class ViewController: UIViewController, ViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var interactor: InteractorProtocol?
    var words: [String] = []
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false /
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countAuxiliar: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor = Interactor(presenter: Presenter(viewController: self))
        
    }
    @IBAction func resetGameTapped(_ sender: UIButton) {
        interactor?.resetGame()
        startButton.isHidden = false
        resetButton.isHidden = true
    }
    
    @IBAction func wordsTextInput(_ sender: UITextField) {
        interactor?.checkWord(answer: sender.text ?? "")
    }
    
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        interactor?.startGame()
        startButton.isHidden = true
        resetButton.isHidden = false
        
    }
    
    func updateList(word: String) {
        words.append(word)
        updateCounter()
        tableView.reloadData()
    }
    
    func updateCounter() {
        countAuxiliar.text = "\(words.count)"
    }
    
    func displayQuestion(question:String) {
        self.question.text = question
    }
    
    // MARK -- Table View Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "wordsList", for: indexPath) as? WordsTableViewCell {
            cell.word.text = words[indexPath.row]
            return cell
        } else {
            fatalError()
        }
    }

}

