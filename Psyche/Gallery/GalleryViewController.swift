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
import HCVimeoVideoExtractor
import YoutubeSourceParserKit
import Kingfisher
class GalleryViewController: UIViewController, FMMosaicLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate, UIScrollViewDelegate{
    
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
    var isWaiting: Bool = true
    var pageNumber: Int = 1
    var playing: Bool = false
    var selected : Int = 0
    var scrollstatus: Bool = true
    
    
    
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
        let mediaDetails: MediaDetails?
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
        let sizes: Sizes?
        let hwstringSmall: String?
        
        enum CodingKeys: String, CodingKey {
            case width, height, file, sizes
            case hwstringSmall = "hwstring_small"
        }
    }
    
    struct Sizes: Decodable {
        let thumbnail: Excerpt
        let mediumLarge, large, hero: Excerpt?
        let heroSm, excerpt: Excerpt?
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
        case imageGIF = "image/gif"
    }
    
    enum MediaType: String, Decodable {
        case image = "image"
    }
    
    var gallery = [GalleryStruct]()
    var collectionviewitems: [Any ] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40 )
        activityIndicator.center = CGPoint(x:  view.frame.width/2,  y: view.frame.height/2 )
        collectionView .addSubview(activityIndicator)
        
        captionText.delegate = self
        captionText.isUserInteractionEnabled = true // default: true
        captionText.isEditable = false // default: true
        captionText.isSelectable = true // default: true
        captionText.dataDetectorTypes = [.link]
        
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
        Apicall.getRequest(pagenum: self.pageNumber){
            (result) in
            self.activityIndicator.startAnimating()
            switch result {
            case.success(let galleryData):
                self.gallery = self.gallery + galleryData
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            case.failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    func textView(_ captionText: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
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
            layout()
            titleLabel.attributedText = self.gallery[(indexPath.row)].title.convertHtml(family: nil, size: 15)
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
            layout()
            let processor = DownsamplingImageProcessor(size: CGSize(width: 255, height: 255))
            imageViewer.kf.indicatorType = .activity
            imageViewer.kf.setImage(
                with: URL(string: self.gallery[(indexPath.row)].sourceURL ),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
            titleLabel.attributedText = self.gallery[(indexPath.row)].title.convertHtml(family: nil, size: 15)
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(18))
            if (self.gallery[(indexPath.row)].description == ""){
                captionText.attributedText = self.gallery[(indexPath.row)].altText.convertHtml(family: nil , size: 10)
            } else {
                captionText.attributedText = self.gallery[(indexPath.row)].description.convertHtml(family: nil, size: 10)
            }
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
        
        let videoUrl = self.gallery[(selected)].videoURL
        let index = videoUrl.firstIndex(of: ".") ?? videoUrl.endIndex
        
        let urlSource = String(videoUrl[..<index])
        let substring = videoUrl.split(separator: "/")
        let host = substring[1].split(separator: ".")
        let finalString = host[1].split(separator: ".")
     
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
            guard let testURL = NSURL(string: videoUrl) else { return }
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
   
    //method to implement on scroll image load - by Madhukar Raj 03/11/2019s
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.pageNumber += 1
        doPaging(pageNo: self.pageNumber)
    }

    func doPaging(pageNo: Int){
            Apicall.getRequest(pagenum: self.pageNumber){
                (result) in
                switch result {
                case.success(let galleryData):
                    if(!galleryData.isEmpty){
                        self.gallery = self.gallery + galleryData
                        self.collectionView.reloadData()
                    }
                case.failure(let error):
                    fatalError("error: \(error.localizedDescription)")
                }
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
        
        let processor = DownsamplingImageProcessor(size: CGSize(width: 250, height: 250))
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: self.gallery[(indexPath.row)].sourceURL ),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return cell
    }
    //NUMBER OF PHOTOS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    
    /**
     * author: Madhukar Raj
     * method: @layout()
     * this method sets the second view as per iphone 5 screen
     */
    func layout() {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE {
            let guide = secondViewer.safeAreaLayoutGuide
            self.imageViewer.translatesAutoresizingMaskIntoConstraints = false
            self.captionText.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.imageViewer.heightAnchor.constraint(equalToConstant: 255).isActive = true
            self.imageViewer.widthAnchor.constraint(equalToConstant: 255).isActive  = true
            self.imageViewer.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
            self.imageViewer.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40).isActive = true
            self.captionText.widthAnchor.constraint(equalToConstant: 255).isActive = true
            self.captionText.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self.captionText.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 35).isActive = true
            self.captionText.topAnchor.constraint(equalTo: guide.topAnchor, constant: 335).isActive  = true
            self.titleLabel.widthAnchor.constraint(equalToConstant: 255).isActive = true
            self.titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 306).isActive  = true
            self.titleLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: 5).isActive = true
            self.titleLabel.font = UIFont(name: self.titleLabel.font.fontName, size: 5)
            
        }
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
    
    @IBAction func openNASA(_ sender: Any) {
        menuHelper.openNASA(vc: self)
    }
    
    @IBAction func openTeam(_ sender: Any) {
        menuHelper.openTeam(vc: self)
    }
}


