//
//  tableTableViewController.swift
//  MemeMeFirst
//
//  Created by osmanjan omar on 12/11/16.
//  Copyright © 2016 osmanjan omar. All rights reserved.
//

import UIKit




class tableViewController: UITableViewController {
    
    
    //app delegate object for accessing meme array in AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // adding edit button programmatically
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let memes = appDelegate.Memes

        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memes = appDelegate.Memes
        let reuseIdentifier = "tableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! tableViewCell
        cell.tableViewCellImage.image = memes[indexPath.item].originalImage
        cell.topTextOnTableViewCell.text = memes[indexPath.item].topText
        cell.buttomTextOnTableViewCell.text = memes[indexPath.item].buttonText

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        let memes = appDelegate.Memes
        detailVC.memeItem = memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    
    // allow users to delete the memes
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        appDelegate.Memes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    
    }
    
    // allow users to allow move the memes 
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempoMeme = appDelegate.Memes[sourceIndexPath.row]
        appDelegate.Memes.remove(at: sourceIndexPath.row)
        appDelegate.Memes.insert(tempoMeme, at: destinationIndexPath.row)
    }
    
}
