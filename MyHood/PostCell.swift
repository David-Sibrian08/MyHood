//
//  PostCell.swift
//  MyHood
//
//  Created by Sibrian on 9/7/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postImage.layer.cornerRadius =  postImage.frame.size.width / 2
        postImage.clipsToBounds = true
    }
    
    func configureCell(post: Post) {
        postTitle.text = post.title
        postDescription.text = post.postDescription
        postImage.image = DataService.instance.imageForPath(post.imagePath)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
