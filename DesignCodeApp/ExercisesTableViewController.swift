//
//  ExercisesTableViewController.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/19/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        performSegue(withIdentifier: "Present Exercise Dialog", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Exercise Cell", for: indexPath) as! ExerciseTableViewCell
        cell.questions = Array(exercises.values)[indexPath.row]
        cell.delegate = self
        return cell
    }

}

extension ExercisesTableViewController : ExerciseTableViewCellDelegate{
    func exerciseCell(_ cell: ExerciseTableViewCell, didReceiveShareFor exercise: Array<Dictionary<String, Any>>, onScroeCell scoreCell: ScoreCollectionViewCell) {
        
        let message = "🙌 72% in the iOS Design challenge from the Design+Code app by @MengTo"
        let link = URL(string: "https://www.tonyjohnvan.com")!
        guard let image = UIImage(view: scoreCell) else { return }
        let objectToShare = [message, link, image] as Array<Any>
        let activity = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
        activity.excludedActivityTypes = [.airDrop, .addToReadingList, .saveToCameraRoll]
        activity.popoverPresentationController?.sourceView = scoreCell
        present(activity, animated: true)
    }
    
    func exerciseCell(_ cell: ExerciseTableViewCell, receivedAnswer correct: Bool, forQuestion question: Dictionary<String, Any>) {
        performSegue(withIdentifier: "Present Exercise Dialog", sender: nil)
    }
}

extension UIImage{
    convenience init?(view: UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        guard let currentContext = UIGraphicsGetCurrentContext() else {return nil}
        view.layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let graphicImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: graphicImage)
    }
}
