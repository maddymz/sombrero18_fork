//
//  ViewController.swift
//  Gallery
//
//  Created by Samuel Lam on 2/15/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit
import FMMosaicLayout
import AVFoundation

class GalleryViewController: UIViewController, FMMosaicLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    

    //menu items
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    
    //second view outlets
    @IBOutlet var secondViewer: UIView!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var video: UIButton!
    @IBOutlet weak var fadeBack: UIVisualEffectView!
    var playerLayer : AVPlayerLayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MosaicLayout and imageArray Initialization
        let mosaicLayout : FMMosaicLayout = FMMosaicLayout()
        collectionView.collectionViewLayout = mosaicLayout
        
        //Side Menu
        //Add and Hide Menu
        Menu.layer.zPosition = 4;
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
        secondViewer.frame = CGRect(x:-375, y:70, width: self.view.frame.width, height:self.view.frame.height)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (playing)
        {
            if let test = playerLayer{
                test.player!.pause()
            }
        }
        self.hideSecondView(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //clicked thumbnail reveal secondView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(isVideo[indexPath.row]!){
            //imageViewer.loadGif(name: imageArray[(indexPath.row)])
            dateLabel.text = dates[indexPath.row + 4]
            captionText.text = captions[indexPath.row + 4]
            //imageViewer.layer.cornerRadius = 8
            //imageViewer.clipsToBounds = true
            selected = indexPath.row
            //video.isHidden = false
            playVideo(self)
        }
        else{
            video.isHidden = true
            imageViewer.isHidden = false
            imageViewer.image = UIImage(named: imageArray[(indexPath.row%imageArray.count)])
            dateLabel.text = dates[indexPath.row + 4]
            captionText.text = captions[indexPath.row + 4]
            imageViewer.layer.cornerRadius = 8
            imageViewer.clipsToBounds = true
        }
        
        //self.secondViewer.layer.zPosition = 3;
        self.secondViewer.transform = CGAffineTransform(translationX: 375, y: 0)
        UIView.animate(withDuration: 0.5, animations: {
            self.secondViewer.alpha = 1.0
        })

    }
    
    //hide SecondView
    @IBAction func hideSecondView(_ sender: Any) {
        self.secondViewer.alpha = 0.0
        self.secondViewer.transform = CGAffineTransform(translationX: -375, y: 0)
        if let test = playerLayer
        {
            test.player!.pause()
            test.isHidden = true
        }
        imageViewer.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            self.fadeBack.effect = UIBlurEffect(style: .extraLight)
        })
        playing = false
        video.isHidden = true
    }
    
    //PLAY VIDEO
    @IBAction func playVideo(_ sender: Any) {
        video.isHidden = false;
        imageViewer.isHidden = true;
        
        guard let path = Bundle.main.path(forResource: videoName[selected], ofType: videoType[selected]) else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        playerLayer = AVPlayerLayer(player: player)
        //playerLayer.frame = self.view.bounds
        let wsize = self.view.frame.width
        //let hsize = self.view.frame.height
        playerLayer!.frame = CGRect(x: 27, y: 48, width: (wsize-55), height: (wsize-55))
        video.frame = CGRect(x: 27, y: 48, width: (wsize-55), height: (wsize-55))
        playerLayer!.masksToBounds = true
        playerLayer!.cornerRadius = 20


        
        
        self.secondViewer.layer.addSublayer(playerLayer!)
        player.play()
        UIView.animate(withDuration: 1.0, animations: {
            //self.imageViewer.alpha = 0.0
            //self.fadeBack.effect = UIBlurEffect(style: .dark)
        })
        playing = true
    }
    
    @IBAction func toggleState(_ sender: Any) {
        if(playing){
            if let test = playerLayer
            {
                test.player!.pause()
                playing = false
            }
        }
        else {
            if let test = playerLayer
            {
                test.player!.play()
                playing = true
            }
        }
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
        
        if(isVideo[indexPath.row]!)
        {
            imageView.loadGif(name: imageArray[(indexPath.row)])
        }
        else{
            imageView.image = UIImage(named: imageArray[(indexPath.row)])
        }
        return cell
    }
    
    //NUMBER OF PHOTOS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    //INSETS BORDER SIZES
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 25.0, bottom: 5.0, right: 25.0)
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
        self.menuBlur.layer.zPosition = 3
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
    
    @IBAction func news(_ sender: Any) {
        menuHelper.news()
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
    
    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
}


