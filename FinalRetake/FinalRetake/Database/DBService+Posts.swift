//
//  DBService+Posts.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    
    public func addPosts(postImage: UIImage, comment: String) {
        let childByAutoID = DBService.manager.getPosts().childByAutoId()
        childByAutoID.setValue(["userID" : FirebaseAuthService.getCurrentUser()!.uid,
                                "userEmail" : FirebaseAuthService.getCurrentUser()?.email,
                                "postTimeAndDateStamp" : "\(Date().timeIntervalSince1970)",
                                "comment" : comment]) { (error, dbRef) in
                                    if let error = error {
                                        print("addPost error: \(error)")
                                    } else {
                                        print("post added @ database reference: \(dbRef)")
                                        StorageService.manager.storePostImage(postImage: postImage, postID: childByAutoID.key)
                                    }
        }
    }
    
    public func loadAllPosts(completionHandler: @escaping ([Post]?) -> Void) {
        let ref = DBService.manager.getPosts()
        ref.observe(.value) { (snapshot) in
            var allPosts = [Post]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String:Any] {
                    let post = Post.init(dict: dict)
                    allPosts.append(post)
                }
            }
            completionHandler(allPosts)
        }
    }
    
}

