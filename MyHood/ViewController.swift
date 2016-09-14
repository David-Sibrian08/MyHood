//
//  ViewController.swift
//  MyHood
//
//  Created by Sibrian on 9/7/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    //var posts = [Post]()      *this can be removed*
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //load saved posts
        DataService.instance.loadPosts()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.onPostsLoaded(_:)), name: "postsLoaded", object: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //* and replaced with this
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        //if there is a cell available to use, give it and make it a PostCell
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            tableView.beginUpdates()
            
            //delete the cell contents
            DataService.instance.loadedPosts.removeAtIndex(indexPath.row)
            
            //delete the actual cell
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            //call for this item to be removed from NSUserDefaults
            DataService.instance.deletePost([indexPath.row])
            
            tableView.endUpdates()
            
            tableView.reloadData()
        }
    }
    
    @IBAction func editButtonPressed(sender: UIButton) {
        tableView.editing = !tableView.editing
        
        let buttonText = tableView.editing ? "Done" : "Edit"
        sender.setTitle(buttonText, forState: .Normal)
    }
    
    
    func onPostsLoaded(notification: AnyObject) {
        tableView.reloadData()
    }

}

