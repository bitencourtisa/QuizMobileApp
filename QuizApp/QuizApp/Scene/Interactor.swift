//
//  Interactor.swift
//  QuizApp
//
//  Created by isabella.bitencourt on 28/01/20.
//  Copyright © 2020 isabella.bitencourt. All rights reserved.
//

import Foundation

protocol InteractorProtocol {
    func checkWord(answer: String)
    func fetchQuestion()
}

class Interactor: InteractorProtocol {
    
    var presenter: PresenterProtocol?
    var api: QuizAPI = QuizAPI()
    var question: String?
    var answers: [String]?

    
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        api.getCorrectAnswer(success: { (response) in
            self.question = response.question
            self.answers = response.answer
            
        }, failure: { (_ error) in
           
        })
    }
    
    func checkWord(answer: String) {
        guard let quizAnswer = answers else { return }
        if quizAnswer.contains(answer) {
            presenter?.presentWordAtList(word: answer)
        }
    }
    
    func fetchQuestion() {
        guard let question = question else { return }
        presenter?.presentQuestion(question: question)
    }
    
    
}
