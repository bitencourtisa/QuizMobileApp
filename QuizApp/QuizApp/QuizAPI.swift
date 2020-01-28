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
     
        guard let url = URL(string: "https://codechallenge.arctouch.com/quiz/1") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                do {
                    let response = try JSONSerialization.jsonObject(with: data!, options: []) as! QuizModel
                    success(response)
                } catch {
                    failure(error)
                }
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
