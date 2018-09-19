//
//  MoreViewController.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/18/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import MKRingProgressView

class MoreViewController: UIViewController {
    @IBOutlet weak var progress1View: RingProgressView!
    @IBOutlet weak var progress2View: RingProgressView!
    @IBOutlet weak var progress3View: RingProgressView!
    
    @IBOutlet weak var progress1Label: UILabel!
    @IBOutlet weak var progress2Label: UILabel!
    @IBOutlet weak var progress3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let progress = [72,56,45]
        
        progress1Label.animateTo(progress[0])
        progress2Label.animateTo(progress[1])
        progress3Label.animateTo(progress[2])
        
        UIView.animate(withDuration: 1.0) {
            self.progress1View.progress = Double(progress[0]) / 100
            self.progress2View.progress = Double(progress[1]) / 100
            self.progress3View.progress = Double(progress[2]) / 100
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension RingProgressView {
//    func animateTo(_ number : Int){
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(1.0)
//        self.progress = Double(number) / 100
//        CATransaction.commit()
//    }
//}
