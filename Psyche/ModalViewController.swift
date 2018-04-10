//
//  ModalViewController.swift
//  Gallery
//
//  Created by Samuel Lam on 3/17/18.
//  Copyright © 2018 Sam. All rights reserved.
//

import Foundation
import UIKit

protocol ModalViewControllerDelegate: class {
    func removeBlurredBackgroundView()
    //String img = ""
}

class ModalViewController: UIViewController {
    
    weak var delegate: ModalViewControllerDelegate?
    
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageBig: UIImageView!
    
    var img : Int?
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
        
        //ensure that the icon embeded in the cancel button fits in nicely
        cancelButton.imageView?.contentMode = .scaleAspectFit
        
        //add a white tint color for the Cancel button image
        let cancelImage = UIImage(named: "Cancel")
        
        let tintedCancelImage = cancelImage?.withRenderingMode(.alwaysTemplate)
        cancelButton.setImage(tintedCancelImage, for: .normal)
        cancelButton.tintColor = .white
        
        if let testt = img
        {
            date.text = dates[testt]
            caption.text = captions[testt]
            let st:String = String(testt)
            imageBig.image = UIImage(named: st)
            //imageBig.contentMode = .center
            
        }
        imageBig.layer.cornerRadius = 8
        imageBig.clipsToBounds = true
        view.bringSubview(toFront: cancelButton)
        view.sendSubview(toBack: imageBig)
        //view.bringSubview(t)
    }
}


