//
//  DataService.swift
//  MyHood
//
//  Created by Sibrian on 9/8/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//
// Singleton: There is one instance available in memory and it is globally accessible

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService()
    
    let POST_KEY = "posts"
    
    var loadedPosts = [Post]()
    
    func savePosts() {
        
        //turn the array into data
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(loadedPosts)
        
        //give a key to the stored data
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: POST_KEY)
        
        //save to disk
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts() {
        //grab the data/object pertaining to the key
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(POST_KEY) as? NSData {
            
            //take the data and convert it back into an object
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                loadedPosts = postsArray
            }
        }
        
        //notify that the posts are loaded
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    func deletePost(sender: AnyObject) {
        
        //NSUserDefaults needs a mutable array. Create one out of our Post array
        let loadedPost = NSMutableArray(array: loadedPosts)
        
        //remove the object that we have been sent
        loadedPost.removeObject(sender)
        
        //delete the object from NSUserDefaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(POST_KEY)
        //userDefaults.synchronize()
        
        //save mutable array into the loadedPosts array
        if let castArray = loadedPost as NSArray as? [Post] {
            loadedPosts = castArray
        }
        userDefaults.synchronize()
    }

    
    func saveImageAndCreatePath(image: UIImage) -> String {
        //save the image as data
        let imageData = UIImagePNGRepresentation(image)
        
        //each image needs a unique name. Use the time as a way to achieve this
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        
        //create the path with the image name
        let fullPath = documentsPathForFileName(imagePath)
        
        imageData?.writeToFile(fullPath, atomically: true)
        
        return imagePath
    }
    
    //loading of the image
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        
        //append post to loadedPosts
        loadedPosts.append(post)
        
        //save the post
        savePosts()
        
        //load the newly made post
        loadPosts()
    }
    
    //images are stored in DocumentsDirectory
    //name is the name of the image (i.e "image1.png")
    func documentsPathForFileName(name: String) -> String {
        
        //1. grab the path from the documents directory
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let fullPath = path[0] as NSString
        
        //grab that path and append the image name to the end of the path (var/mobile/.../image1.png)
        return fullPath.stringByAppendingPathComponent(name)
    }
    
}
