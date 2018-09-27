//
//  Post.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import Foundation

struct Post {
    let userID: String
    let userEmail: String
    let postTimeAndDateStamp: String
    let comment: String
    let postImageURL: String
    
    init(dict: [String : Any]) {
        userID = dict["userID"] as? String ?? ""
        userEmail = dict["userEmail"] as? String ?? ""
        postTimeAndDateStamp = dict["postTimeAndDateStamp"] as? String ?? ""
        comment = dict["comment"] as? String ?? ""
        postImageURL = dict["postImageURL"] as? String ?? ""
    }
}
