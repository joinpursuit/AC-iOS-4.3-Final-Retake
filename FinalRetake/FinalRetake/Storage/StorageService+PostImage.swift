//
//  StorageService+PostImage.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit

extension StorageService {
    
    public func storePostImage(postImage: UIImage, postID: String) {
        guard let data = UIImageJPEGRepresentation(postImage, 1.0) else {
            print("Image is nil.")
            return
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = StorageService.manager.getPostImagesRef().child(postID).putData(data, metadata: metadata)
        { (StorageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = StorageMetadata {
                print("storageMetadata: \(storageMetadata)")
            }
        }
        
        uploadTask.observe(.resume) { snapshot in
        }
        
        uploadTask.observe(.pause) { snapshot in
        }
        
        uploadTask.observe(.success) { snapshot in
            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)
            DBService.manager.getPosts().child("\(postID)/postImageURL").setValue(imageURL)
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    break
                case .unauthorized:
                    break
                case .cancelled:
                    break
                case .unknown:
                    break
                default:
                    break
                }
            }
        }
    }
}
