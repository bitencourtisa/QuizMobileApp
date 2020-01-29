//
//  WordsTableViewCell.swift
//  QuizApp
//
//  Created by isabella.bitencourt on 28/01/20.
//  Copyright © 2020 isabella.bitencourt. All rights reserved.
//

import UIKit

class WordsTableViewCell: UITableViewCell {

    @IBOutlet weak var word: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with answer: String) {
        word.text = answer
        
    }

}
