//
//  SectionViewController.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/13/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var subheadVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var closeVisualEffectView: UIVisualEffectView!
    
    var section: Section!
    var sections: Array<Section>!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable.text = section.title
        captionLabel.text = section.caption
        bodyLabel.text = section.body
        coverImageView.image = UIImage(named: section.imageName!)
        
        progressLabel.text = "\(indexPath.row+1) / \(sections.count)"
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
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

public extension UIViewController {
    @IBAction public func unwindToViewController (_ segue : UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
