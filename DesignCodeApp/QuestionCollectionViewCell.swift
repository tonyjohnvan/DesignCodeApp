//
//  QuestionCollectionViewCell.swift
//  DesignCodeApp
//
//  Created by fanzhang on 9/19/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

protocol QuestioncellDelegate : class {
    func questionCell(_ cell: QuestionCollectionViewCell, didTapAnswerButton button : UIButton, forQuestion question : Dictionary<String,Any>)
}

class QuestionCollectionViewCell: UICollectionViewCell {
    var question : Dictionary<String,Any>!
    
    weak var delegate : QuestioncellDelegate?
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBAction func didTapAnswerButton(_ sender: UIButton) {
        sender.setImage(UIImage(named: "Exercises-Check"), for: .normal)
        delegate?.questionCell(self, didTapAnswerButton: sender, forQuestion: question)
    }
    
}
