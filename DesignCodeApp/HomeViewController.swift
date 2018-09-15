//
//  ViewController.swift
//  DesignCodeApp
//
//  Created by Meng To on 11/14/17.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deviceImage: UIImageView!
    @IBOutlet weak var playVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var bookView: UIView!
    @IBOutlet weak var chapterCollectionView: UICollectionView!
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let urlString = "https://player.vimeo.com/external/235468301.hd.mp4?s=e852004d6a46ce569fcf6ef02a7d291ea581358e&profile_id=175"
        
        let url = URL(string: urlString)
        let player = AVPlayer(url: url!)
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        
        present(playerController,animated: true){
            player.play()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        
        scrollView.delegate = self
        chapterCollectionView.delegate = self
        chapterCollectionView.dataSource = self
        
        super.viewDidLoad()
        
        titleLabel.alpha = 0
        deviceImage.alpha = 0
        playVisualEffectView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.titleLabel.alpha = 1
            self.deviceImage.alpha = 1
            self.playVisualEffectView.alpha = 1
        }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 0.5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToSection"{
            let toViewController = segue.destination as! SectionViewController
            let indexPath = sender as! IndexPath
            let section = sections[indexPath.row]
            
            toViewController.section = section
            toViewController.sections = sections
            toViewController.indexPath = indexPath
        }
    }


}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! SectionCollectionViewCell
        let section = sections[indexPath.row]
        cell.titleLabel.text = section["title"]
        cell.captionLabel.text = section["caption"]
        cell.coverImageView.image = UIImage(named: section["image"]!)
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeToSection", sender: indexPath)
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        
        // Hero Section Animations
        if offsetY < 0 {
            heroView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            
            playVisualEffectView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            titleLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            deviceImage.transform = CGAffineTransform(translationX: 0, y: -offsetY/4)
            backgroundImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
            //backgroundImageView.transform = CGAffineTransform(scaleX: 1+(-offsetY/500), y: 1+(-offsetY/500))
        }
        
        if let collectionView = scrollView as? UICollectionView{
            for cell in collectionView.visibleCells as! [SectionCollectionViewCell] {
                let indexPath = collectionView.indexPath(for: cell)!
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                
                // animation starts here
                let translationX = cellFrame.origin.x / 5
                cell.coverImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                
                cell.layer.transform = animateCell(cellFrame: cellFrame)
            }
        } else {
            
            //NavigationBar Behavior
            let navigationIsHidden = offsetY <= 0
            navigationController?.setNavigationBarHidden(navigationIsHidden, animated: true)
        }
    }
    
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        
        let angleFromX = Double((-cellFrame.origin.x)/10)
        let angle = CGFloat((angleFromX * Double.pi)/180.0)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        //cell.layer.transform = rotation
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        
        if scaleFromX > scaleMax{
            scaleFromX = scaleMax
        }
        
        if scaleFromX < scaleMin{
            scaleFromX = scaleMin
        }
        
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        //cell.layer.transform = CATransform3DConcat(rotation, scale)
        return CATransform3DConcat(rotation, scale)
    }
}

