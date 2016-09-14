//
//  AddPostViewController.swift
//  MyHood
//
//  Created by Sibrian on 9/8/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit

//With an image picker you need pickerController and navigationController delegates
class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        postImage.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddPostViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func didTapView() {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makePostButtonPressed(sender: UIButton) {
        
        if let title = titleTextField.text, let description = descriptionTextField.text, let image = postImage.image {
            
            if isOnlyWhitespace(title, description: description) {
                postMissingComponentsAlert()
            } else {
                let imagePath = DataService.instance.saveImageAndCreatePath(image)
                let post = Post(imagePath: imagePath, title: title, description: description)
                DataService.instance.addPost(post)
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPictureButtonPressed(sender: UIButton) {
        sender.setTitle("", forState: .Normal)
        
        //image picker counts as a view controller. We can present it like this...
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //mandatory function
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
        
    }
    
    func postMissingComponentsAlert() {
        let alertController = UIAlertController(title: "Incomplete Post", message: "Make sure your post has a photo, a title and a description.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Oops. I forgot! ", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func isOnlyWhitespace(title: String, description: String) -> Bool {
        let whiteSpace = NSCharacterSet.whitespaceCharacterSet()
        
        if title.stringByTrimmingCharactersInSet(whiteSpace) == "" || description.stringByTrimmingCharactersInSet(whiteSpace) == "" {
            return true
        }
        return false
    }
    
}
