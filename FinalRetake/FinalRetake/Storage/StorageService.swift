//
//  StorageService.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        postImagesRef = storageRef.child("postImages")
    }
    static let manager = StorageService()
    
    let firebaseAuthService = FirebaseAuthService()
    
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var postImagesRef: StorageReference!
    
    public func getStorageRef() -> StorageReference { return storageRef }
    public func getPostImagesRef() -> StorageReference { return postImagesRef }
}
