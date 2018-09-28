//
//  BookmarksTableViewController.swift
//  DesignCodeApp
//
//  Created by Fan Zhang on 9/14/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarksTableViewController: UITableViewController {

    //var bookmarks : Array<Bookmark> = ContentAPI.shared.bookmarks
    var bookmarks : Results<Bookmark> {return RealmManager.bookmarks}
    //var sections : Array<Section> = ContentAPI.shared.sections
    var sections : Results<Section> {return RealmManager.sections}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookmarks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarkTableViewCell
//        let cell = UITableViewCell()
        
        let bookmark = bookmarks[indexPath.row]
        
        let section = bookmark.section
        let part = bookmark.part
        
        cell.chapterNumberLabel.text = section?.chapterNumber
        cell.chapterTitleLabel.text = section?.title.uppercased()
        cell.titleLabel.text = part?.title
        cell.bodyLabel.text = part?.content
        cell.badgeImageView.image = UIImage(named: "Bookmarks/" + (part?.typeName ?? "text"))
        
        
//        cell.textLabel?.text = bookmarks[indexPath.row]["content"]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Bookmarks to Section", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Bookmarks to Section", let desination = segue.destination as? SectionViewController{
            desination.section = sections[0]
            desination.sections = sections
            desination.indexPath = sender as! IndexPath
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            // Delete the row from the data source
            
            let bookmark = self.bookmarks[indexPath.row]
            
            RealmManager.remove(bookmark)
            tableView.deleteRows(at: [indexPath], with: .top)
            
            tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
