//
//  DBService.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    
    private var dbRef: DatabaseReference!
    private var postsRef: DatabaseReference!
    
    private init() {
        dbRef = Database.database().reference()
        postsRef = dbRef.child("posts")
    }
    
    static let manager = DBService()
    
    public func getDB()-> DatabaseReference { return dbRef }
    public func getPosts()-> DatabaseReference { return postsRef }
    
}
