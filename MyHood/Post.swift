//
//  Post.swift
//  MyHood
//
//  Created by Sibrian on 9/7/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import Foundation

class Post {
    private var imagePath: String
    private var title: String
    private var postDescription: String
    
    init(imagePath: String, title: String, description: String) {
        self.imagePath = imagePath
        self.title = title
        self.postDescription = description
    }
}
