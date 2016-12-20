//
//  detailViewCellViewController.swift
//  MemeMe 2.0
//
//  Created by osmanjan omar on 12/16/16.
//  Copyright © 2016 osmanjan omar. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    // uiview outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    // referencing MeMeStruct to access meme array
    
    var memeItem : MeMeme!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        memeImageView.image = memeItem.memeImage
                       
    }
    

}
