//
//  ScoreCollectionViewCell.swift
//  DesignCodeApp
//
//  Created by fanzhang on 9/19/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import MKRingProgressView

protocol ScroeCellDelegate : class {
    func scoreCell(_ cell : ScoreCollectionViewCell, didTapTryAgainExercise exercise : Array<Dictionary<String,Any>>)
    func scoreCell(_ cell : ScoreCollectionViewCell, didTapShareExercise exercise : Array<Dictionary<String,Any>>)
}

class ScoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var percentageView: RingProgressView!
    
    weak var delegate : ScroeCellDelegate?
    
    var exercise : Array<Dictionary<String,Any>>!
    
    @IBAction func tryAgainButtonTapped(_ sender: UIButton) {
        delegate?.scoreCell(self, didTapTryAgainExercise: exercise)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        delegate?.scoreCell(self, didTapShareExercise: exercise)
    }
    
    override func awakeFromNib() {
        percentageLabel.animateTo(72)
        percentageView.animateTo2(72)
    }
}
