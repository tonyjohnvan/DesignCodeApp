//
//  ExerciseTableViewCell.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/19/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

protocol ExerciseTableViewCellDelegate : class {
    func exerciseCell(_ cell : ExerciseTableViewCell, receivedAnswer correct : Bool, forQuestion question: Dictionary<String, Any>)
    
    func exerciseCell(_ cell : ExerciseTableViewCell, didReceiveShareFor exercise : Array<Dictionary<String,Any>>, onScroeCell scoreCell : ScoreCollectionViewCell)
}

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate : ExerciseTableViewCellDelegate?
    
    var questions : Array<Dictionary<String, Any>>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.dataSource = self
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ExerciseTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == questions.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Score Cell", for: indexPath) as! ScoreCollectionViewCell
            cell.exercise = questions
            cell.delegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Question Cell", for: indexPath) as! QuestionCollectionViewCell
        
        let question = questions[indexPath.row]
        cell.question = question
        cell.delegate = self
        cell.questionLabel.text = question["question"] as? String
        if let possibleAnswers = question["answers"] as? Array<String>{
            for index in 0..<possibleAnswers.count {
                cell.answerButtons[index].setTitle(possibleAnswers[index], for : .normal)
            }
        }
        
        return cell
    }
}

extension ExerciseTableViewCell : ScroeCellDelegate{
    func scoreCell(_ cell: ScoreCollectionViewCell, didTapTryAgainExercise exercise: Array<Dictionary<String, Any>>) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
    func scoreCell(_ cell: ScoreCollectionViewCell, didTapShareExercise exercise: Array<Dictionary<String, Any>>) {
        delegate?.exerciseCell(self, didReceiveShareFor: exercise, onScroeCell: cell)
    }
    
}

extension ExerciseTableViewCell : QuestioncellDelegate{
    func questionCell(_ cell: QuestionCollectionViewCell, didTapAnswerButton button: UIButton, forQuestion question: Dictionary<String, Any>) {
        let indexPath = collectionView.indexPath(for: cell)!
        let nextIndex = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        if indexPath.row < questions.count {
            collectionView.scrollToItem(at: nextIndex, at: .centeredHorizontally, animated: true)
        }
        
        var answerCorrect : Bool = false
        if let correctAnswer = question["correctAnswer"] as? String, let answer = button.titleLabel?.text {
            answerCorrect = correctAnswer == answer
        }
        delegate?.exerciseCell(self, receivedAnswer: answerCorrect, forQuestion: question)
    }
    
    
}
