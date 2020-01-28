//
//  Presenter.swift
//  QuizApp
//
//  Created by isabella.bitencourt on 28/01/20.
//  Copyright © 2020 isabella.bitencourt. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    func presentQuestion(question: String)
    func presentWordAtList(word: String)
}

class Presenter: PresenterProtocol {

    var viewController: ViewControllerProtocol?
    
    init(viewController: ViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func presentWordAtList(word: String) {
        viewController?.updateList(word: word)
    }
    
    func presentQuestion(question: String) {
        viewController?.displayQuestion(question: question)
    }
    
    func presentDialogError() {
        
    }
}
