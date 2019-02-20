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
import SDWebImage
import HCVimeoVideoExtractor
import YoutubeSourceParserKit
class GalleryViewController: UIViewController, FMMosaicLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate{
    
    //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //menu items
    @IBOutlet var Menu: UIView!
    @IBOutlet weak var menuBlur: UIVisualEffectView!
    
    
    //second view outlets
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var secondViewer: UIView!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var video: UIButton!
    @IBOutlet weak var fadeBack: UIVisualEffectView!
    var playerLayer : AVPlayerLayer?
    var activityIndicator = UIActivityIndicatorView()
    
    
    //struct model to hold the gallery json data: by Madhukar Raj 01/17/2019
    struct GalleryStruct: Decodable {
        let id: Int
        let date, dateGmt, modified, modifiedGmt: String
        let slug: String
        let link: String
        let title: String
        let description, caption, photoCredit: String
        let videoURL: String
        let altText: String
        let mediaType: MediaType
        let mimeType: MIMEType
        let mediaDetails: MediaDetails
        let sourceURL: String
        
        enum CodingKeys: String, CodingKey {
            case id, date
            case dateGmt = "date_gmt"
            case modified
            case modifiedGmt = "modified_gmt"
            case slug, link, title,description, caption
            case photoCredit = "photo_credit"
            case videoURL = "video_url"
            case altText = "alt_text"
            case mediaType = "media_type"
            case mimeType = "mime_type"
            case mediaDetails = "media_details"
            case sourceURL = "source_url"
        }
    }
    
    struct MediaDetails: Decodable {
        let width, height: Int
        let file: String
        let sizes: Sizes
        let hwstringSmall: String?
        
        enum CodingKeys: String, CodingKey {
            case width, height, file, sizes
            case hwstringSmall = "hwstring_small"
        }
    }
    
    struct Sizes: Decodable {
        let thumbnail: Excerpt
        let mediumLarge, large, hero: Excerpt?
        let heroSm, excerpt: Excerpt
        let full: Excerpt
        
        enum CodingKeys: String, CodingKey {
            case thumbnail
            case mediumLarge = "medium_large"
            case large, hero
            case heroSm = "hero-sm"
            case excerpt,full
        }
    }
    
    struct Excerpt: Decodable {
        let file: String
        let width, height: Int
        let mimeType: MIMEType?
        let sourceURL: String
        let path: String?
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case file, width, height
            case mimeType = "mime_type"
            case sourceURL = "source_url"
            case path, url
        }
    }
    
    enum MIMEType: String, Decodable {
        case imageJPEG = "image/jpeg"
        case imagePNG = "image/png"
    }
    
    enum MediaType: String, Decodable {
        case image = "image"
    }
    
    var gallery = [GalleryStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: 187.5,  y: 271.5 )
        collectionView .addSubview(activityIndicator)
        
    
        captionText.delegate = self
        captionText.isUserInteractionEnabled = true // default: true
        captionText.isEditable = false // default: true
        captionText.isSelectable = true // default: true
        captionText.dataDetectorTypes = [.link]
//        activityIndicator.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5 )
        
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
        self.activityIndicator.startAnimating()
        Apicall.getRequest(for: 1){
            (result) in
//            self.activityIndicator.startAnimating()
            switch result {
            case.success(let galleryData):
                self.gallery = galleryData
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            case.failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    func textView(_ captionText: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("Link Selected!")
        return true
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
        
        if(self.gallery[(indexPath.row)].videoURL != ""){
            titleLabel.text = self.gallery[(indexPath.row)].title
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(18))
            if (self.gallery[(indexPath.row)].description == ""){
                captionText.attributedText = self.gallery[(indexPath.row)].altText.convertHtml(family: nil , size: 10)
            }else {
                captionText.attributedText = self.gallery[(indexPath.row)].description.convertHtml(family: nil , size: 10)
            }
            selected = indexPath.row
            playVideo(self)
        }
        else{
            video.isHidden = true
            imageViewer.isHidden = false
            imageViewer.sd_setImage(with: URL(string: self.gallery[(indexPath.row)].sourceURL ))
            titleLabel.text = self.gallery[(indexPath.row)].title
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(18))
            print("date label", titleLabel.text!)
            if (self.gallery[(indexPath.row)].description == ""){
                captionText.attributedText = self.gallery[(indexPath.row)].altText.convertHtml(family: nil , size: 10)
            } else {
                captionText.attributedText = self.gallery[(indexPath.row)].description.convertHtml(family: nil, size: 10)
            }
            print("capriontext:", captionText.text)
            imageViewer.layer.cornerRadius = 8
            imageViewer.clipsToBounds = true
        }
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
        
//        guard let path = Bundle.main.path(forResource: videoName[selected], ofType: videoType[selected]) else {
//            debugPrint("video.m4v not found")
//            return
//        }
        let videoUrl = self.gallery[(selected)].videoURL
        let index = videoUrl.firstIndex(of: ".") ?? videoUrl.endIndex
        print("index:", index)
        
        let urlSource = String(videoUrl[..<index])
        let substring = videoUrl.split(separator: "/")
        let host = substring[1].split(separator: ".")
        let finalString = host[1].split(separator: ".")
        print("finalstring:", finalString)
        print("host:", host)
        print("substring:", substring)
        print("usrlorigin:",substring[1])
        print("urlsource", urlSource)
       
        func play(videoUrl: URL){
            let player = AVPlayer(url: videoUrl)
            self.playerLayer = AVPlayerLayer(player: player)
            //playerLayer.frame = self.view.bounds
            let wsize = self.view.frame.width
            //let hsize = self.view.frame.height
            self.playerLayer!.frame = CGRect(x: 27, y: 48, width: (wsize-55), height: (wsize-55))
            self.video.frame = CGRect(x: 27, y: 48, width: (wsize-55), height: (wsize-55))
            self.playerLayer!.masksToBounds = true
            self.playerLayer!.cornerRadius = 20
            
            self.secondViewer.layer.addSublayer(self.playerLayer!)
            player.play()
            UIView.animate(withDuration: 1.0, animations: {
                //self.imageViewer.alpha = 0.0
                //self.fadeBack.effect = UIBlurEffect(style: .dark)
            })
            playing = true
        }
        /*
         **madhukar raj: 02/08/2019
         **switch case
         **handles the video playback
         **based on urls form vimeo and youtube
        */
        
        switch true {
        case substring[1].contains("vimeo"):
            let url = URL(string: videoUrl)!
            // this function call extracts the video extension from the vimeo url: by Madhukar Raj 02/08/2019
            HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
                if let err = error {
                    print("Error = \(err.localizedDescription)")
                    return
                }
                guard let vid = video else {
                    print("Invalid video object")
                    return
                }
                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
                if let videoURL = vid.videoURL[.Quality540p] {
                    play(videoUrl: videoURL)
                }
            })
        case substring[1].contains("youtu") :
            let testURL = NSURL(string: videoUrl)!
            Youtube.h264videosWithYoutubeURL(youtubeURL: testURL) { (videoInfo, error) -> Void in
                let youtubeUrl = URL(string: (videoInfo?["url"] as? String)!)
                play(videoUrl: youtubeUrl!)
            }
        case substring[1].contains("youtube") :
            let testURL = NSURL(string: videoUrl)!
            Youtube.h264videosWithYoutubeURL(youtubeURL: testURL) { (videoInfo, error) -> Void in
                let youtubeUrl = URL(string: (videoInfo?["url"] as? String)!)
               play(videoUrl: youtubeUrl!)
            }
        default:
            print("url error!!")
        }
       
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) 
        cell.layer.cornerRadius = 8
     
        let imageView = cell.viewWithTag(2) as! UIImageView
        imageView.sd_setImage(with: URL(string: self.gallery[(indexPath.row)].sourceURL ))
        return cell
    }
    
    //NUMBER OF PHOTOS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("item count:", self.gallery.count)
        return self.gallery.count
        
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
        menuHelper.events(vc: self)
    }
    
    @IBAction func contactUs(_ sender: Any) {
        menuHelper.contactUs(vc: self)
    }
    
    @IBAction func science(_ sender: Any) {
        menuHelper.science(vc: self)
    }
    
    @IBAction func getInvolved(_ sender: Any) {
        menuHelper.getInvolved(vc: self)
    }
    
    @IBAction func blog(_ sender: Any) {
        menuHelper.blog(vc: self)
    }
    
    @IBAction func mission(_ sender: Any) {
        menuHelper.mission(vc: self)
    }
    
    @IBAction func news(_ sender: Any) {
        menuHelper.news(vc: self)
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


