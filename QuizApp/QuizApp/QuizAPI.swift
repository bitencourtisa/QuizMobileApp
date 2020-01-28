//
//  QuizAPI.swift
//  QuizApp
//
//  Created by isabella.bitencourt on 28/01/20.
//  Copyright © 2020 isabella.bitencourt. All rights reserved.
//

import UIKit

class QuizAPI: NSObject {
    
    func getCorrectAnswer(success: @escaping(_ response: QuizModel) -> Void, failure:@escaping(_ error:Error) -> Void) {
     
        let url = URL(string: "https://codechallenge.arctouch.com/quiz/1")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(QuizModel.self, from: data!)
                    success(responseModel)
                } catch {
                    failure(error)
                }
            }
        task.resume()
    }
    
    func parseJSON(data: Data) -> QuizModel? {
        
        var returnValue: QuizModel?
        do {
            returnValue = try JSONDecoder().decode(QuizModel.self, from: data)
        } catch {
            print("Error took place\(error.localizedDescription).")
        }
        
        return returnValue
    }
}
