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
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var section: [String: String]!
    var sections: [[String: String]]!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable.text = section["title"]
        captionLabel.text = section["caption"]
        bodyLabel.text = section["body"]
        coverImageView.image = UIImage(named: section["image"]!)
        
        progressLabel.text = "\(indexPath.row+1) / \(sections.count)"
        
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
