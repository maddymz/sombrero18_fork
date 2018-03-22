//
//  ViewController.swift
//  Gallery
//
//  Created by Samuel Lam on 2/15/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import UIKit
import FMMosaicLayout

class ViewController: UICollectionViewController, FMMosaicLayoutDelegate, ModalViewControllerDelegate{
    
    //@IBOutlet weak var popup: UIImageView!
    
    
    var imageArray = [String]()
    var indexPathfor:IndexPath?
    var it : UIImage?
    var c : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //popup.isHidden = true;
        let mosaicLayout : FMMosaicLayout = FMMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        
        imageArray = ["1","2","3","4","5","6","7","8"]

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        self.overlayBlurredBackgroundView()
        //let cell = collectionView.cellForItem(at: indexPath)
        //var imagething = cell as! UIImageView
        //image = imagething
        
        
        let imageView = UIImageView(image: UIImage(named: imageArray[indexPath.row%imageArray.count]))
        it = UIImage(named: imageArray[indexPath.row%imageArray.count])!
        
        c = (indexPath.row + 1)%imageArray.count
        
        
        
        //popup = imageView
        
        indexPathfor = indexPath
        
        performSegue(withIdentifier: "ShowModalView", sender: self)
        
        if(1==0)
        {
        imageView.frame = self.view.frame
        //imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imageView.addGestureRecognizer(tap)
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .regular)
        
        let tapp = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        blurredBackgroundView.addGestureRecognizer(tapp)
        
        view.addSubview(blurredBackgroundView)
        
        self.view.addSubview(imageView)
        }
    }
    
    //TEST
    
    
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    //END TEST
    
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowModalView" {
                if let viewController = segue.destination as? ModalViewController {
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                    viewController.img = c
                    //viewController.imageBig.image = it
                }
            }
        }
    }
    
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .extraLight)
        
        view.addSubview(blurredBackgroundView)
        
    }
    
    //NUMBER OF COLUMNS
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 2
    }
    
    //CHANGE CELL
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UICollectionViewCell
        
        cell.layer.cornerRadius = 8
        
        var imageView = cell.viewWithTag(2) as! UIImageView
        imageView.image = UIImage(named: imageArray[(indexPath.row%imageArray.count)])
        
        return cell
    }
    
    //NUMBER OF PHOTOS
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        return indexPath.item % 4 == 0 ? FMMosaicCellSize.big : FMMosaicCellSize.small
        
        if(1==2)
        {
        if (indexPath.item == 20)
        {
            return FMMosaicCellSize.small
        }
        if (indexPath.item == 5)
        {
            return FMMosaicCellSize.small
        }
        if (indexPath.item == 10)
        {
            return FMMosaicCellSize.small
        }
        if (indexPath.item == 15)
        {
            return FMMosaicCellSize.small
        }
        else
        {
            return FMMosaicCellSize.big
        }
        }
        
    }
    
    //func colle
    
    


}

