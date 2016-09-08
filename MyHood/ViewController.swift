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
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let post1 = Post(imagePath: "", title: "POST 1", description: "Test post for testing purposes")
        posts.append(post1)
        
        let post2 = Post(imagePath: "", title: "Post 2", description: "THE THE THE THE THE THE THE THE THE THE THE THE THE")
        posts.append(post2)
        
        let post3 = Post(imagePath: "", title: "Post 3", description: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
        
        posts.append(post3)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
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
        return posts.count
    }

}

