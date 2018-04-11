//
//  ViewController.swift
//  Gallery
//
//  Created by Samuel Lam on 2/15/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit
import FMMosaicLayout

class GalleryViewController: UIViewController, FMMosaicLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    //@IBOutlet weak var popup: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [String]()
    var indexPathfor:IndexPath?
    var it : UIImage?
    var c : Int?
    
    //menu items
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    
    //second view outlets


    @IBOutlet var secondViewer: UIView!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MosaicLayout
        let mosaicLayout : FMMosaicLayout = FMMosaicLayout()
        collectionView.collectionViewLayout = mosaicLayout
        imageArray = ["4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19"]
        
        //Side Menu
        //Add and Hide Menu
        Menu.layer.zPosition = 2;
        view.addSubview(Menu)
        Menu.frame = CGRect(x:-300, y:0, width: 265, height:self.view.frame.height)
        //tap recognizer to close menu
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
        self.menuBlur.addGestureRecognizer(tapOut)
        
        //SecondView
        //Add and Hide View
        secondViewer.layer.zPosition = 2;
        view.addSubview(secondViewer)
        secondViewer.alpha = 0.0
        secondViewer.frame = CGRect(x:-375, y:70, width: 375, height:self.view.frame.height)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //clicked thumbnail reveal secondView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        imageViewer.image = UIImage(named: imageArray[(indexPath.row%imageArray.count)])
        dateLabel.text = dates[indexPath.row + 4]
        captionText.text = captions[indexPath.row + 4]
        imageViewer.layer.cornerRadius = 8
        imageViewer.clipsToBounds = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.secondViewer.alpha = 1.0
            self.secondViewer.transform = CGAffineTransform(translationX: 375, y: 0)

        })

    }
    
    //hide SecondView
    @IBAction func hideSecondView(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.secondViewer.alpha = 0.0
            self.secondViewer.transform = CGAffineTransform(translationX: -375, y: 0)
        })
    }
    
    
    
    //TEST
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    //END TEST
    
    
    //NUMBER OF COLUMNS
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 2
    }
    
    //CHANGE CELL
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
        
        cell.layer.cornerRadius = 8
        
        var imageView = cell.viewWithTag(2) as! UIImageView
        
        if(indexPath.row == 0)
        {
            imageView.loadGif(name: "output")
        }
        imageView.image = UIImage(named: imageArray[(indexPath.row%imageArray.count)])
        
        return cell
    }
    
    //NUMBER OF PHOTOS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count*3
    }
    
    //INSETS BORDER SIZES
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25.0, left: 25.0, bottom: 5.0, right: 25.0)
    }
    
    //ITERITEM SPACING
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //WHEN BIG WHEN SMALL
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        
        return indexPath.item % 3 == 0 ? FMMosaicCellSize.big : FMMosaicCellSize.small
    }
    
    //menu functions (include in all pages with hamburger)
    @IBAction func menuClicked(_ sender: Any) {
        self.menuBlur.layer.zPosition = 1
        self.menuBlur.alpha = 0
        self.menuBlur.layer.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.menuBlur.alpha = 1.0
            self.tabBarController?.tabBar.alpha = 0
            self.Menu.transform = CGAffineTransform(translationX: 300, y: 0)
        }) { (success) in
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    
    @IBAction func closeMenu(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.alpha = 1.0
            self.menuBlur.alpha = 0
            self.Menu.transform = CGAffineTransform(translationX: -300, y: 0)
        }) { (success) in
            self.menuBlur.layer.isHidden = true
        }
    }
    
    @IBAction func events(_ sender: Any) {
        menuHelper.events()
    }
    
    @IBAction func contactUs(_ sender: Any) {
        menuHelper.contactUs()
    }
    
    @IBAction func science(_ sender: Any) {
        menuHelper.science()
    }
    
    @IBAction func getInvolved(_ sender: Any) {
        menuHelper.getInvolved()
    }
    
    @IBAction func blog(_ sender: Any) {
        menuHelper.blog()
    }
    
    @IBAction func mission(_ sender: Any) {
        menuHelper.mission()
    }
    
    @IBAction func openYoutube(_ sender: Any) {
        menuHelper.openYoutube(vc: self)
    }
    
    @IBAction func openTwitter(_ sender: Any) {
        menuHelper.openTwitter(vc: self)
    }
    
    @IBAction func openFB(_ sender: Any) {
        menuHelper.openFB(vc: self)
    }
    
    @IBAction func openInsta(_ sender: Any) {
        menuHelper.openInsta(vc: self)
    }
}


