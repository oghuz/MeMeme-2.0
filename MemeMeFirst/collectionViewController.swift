//
//  collectionViewControllerCollectionViewController.swift
//  MemeMeFirst
//
//  Created by osmanjan omar on 12/11/16.
//  Copyright © 2016 osmanjan omar. All rights reserved.
//

import UIKit

 private let reuseIdentifier = "collectionViewCell"



class collectionViewController: UICollectionViewController {
    
    
    //app delegate object for accessing meme array in AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    // collectionview flow layout reference
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
        
    // setting up collection view items spacing and size with different orientation
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation) {
            self.flowlayOut(spacee: 10, numberOfItems: 3)
        }
        else
        {
        self.flowlayOut(spacee: 10, numberOfItems: 5)
            
        }
    }
    
    // reusable func for configuring collection item
    func flowlayOut(spacee:CGFloat, numberOfItems:CGFloat){
    
        let space : CGFloat = spacee
        let numberOfItem : CGFloat = numberOfItems
        let itemDimention = (self.view.frame.size.width - ( (numberOfItem - 1) * space )) / numberOfItem
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: itemDimention, height: itemDimention)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let memes = appDelegate.Memes
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let memes = appDelegate.Memes
        
        //configuring the cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! collectionViewCell
        cell.backgroundColor = UIColor.black
        cell.collectionItemImage.image = memes[indexPath.item].originalImage
        cell.topTextLabel.text = memes[indexPath.item].topText
        cell.buttomTextLabel.text = memes[indexPath.item].buttonText
        
        
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        let memes = appDelegate.Memes
        detailVC.memeItem = memes[indexPath.item]
        
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    
}
