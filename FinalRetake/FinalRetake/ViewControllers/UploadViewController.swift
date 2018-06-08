//
//  UploadViewController.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit
import SystemConfiguration

class UploadViewController: UIViewController {
    
    let uploadView = UploadView()
    let postTableViewCell = PostTableViewCell()
    let imagePicker = UIImagePickerController()
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(uploadView)
        imagePicker.delegate = self
        uploadView.commentTextView.delegate = self
        setupNavBar()
        setupNewPostImageViewGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func setupNavBar() {
        navigationItem.title = "Create a Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(post))
    }
    
    @objc func post() {
        uploadView.commentTextView.resignFirstResponder()
        if !isInternetAvailable() {
            showAlert(title: "Upload Failed", message: "No network connection detected right now. Please try again later.")
            return
        }
        var imageToUpload = uploadView.newUserPostImageView.image
        var commentToAdd = uploadView.commentTextView.text
        DBService.manager.addPosts(postImage: imageToUpload ?? #imageLiteral(resourceName: "camera_icon"), comment: commentToAdd!)
        showAlert(title: "Post Uploaded", message: "")
        if imageToUpload != #imageLiteral(resourceName: "camera_icon") {
            postTableViewCell.postCommentLabel.isHidden = true
            return
        }
        if commentToAdd != "Enter your comment here." {
            postTableViewCell.postImageView.isHidden = true
        }
    }
    
    private func setupNewPostImageViewGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(newPostImageTapped(tapGestureRecognizer:)))
        uploadView.newUserPostImageView.isUserInteractionEnabled = true
        uploadView.newUserPostImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func newPostImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imageAlertController = UIAlertController(title: "Add Post Image", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let cameraRollAccessAction = UIAlertAction(title: "From Camera Roll", style: UIAlertActionStyle.default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelUpLoadAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        imageAlertController.addAction(cameraRollAccessAction)
        imageAlertController.addAction(cancelUpLoadAction)
        present(imageAlertController, animated: true, completion: nil)
    }
    
    func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            showAlert(title: "Error", message: "Error selecting image.")
            return
        }
        uploadView.newUserPostImageView.contentMode = .scaleAspectFit
        uploadView.newUserPostImageView.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UploadViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
}
