//
//  UploadView.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit

class UploadView: UIView {
    
    lazy var newUserPostImageView: UIImageView = {
        let newPost = UIImageView()
        newPost.image = #imageLiteral(resourceName: "camera_icon")
        newPost.contentMode = .center
        newPost.backgroundColor = UIColor.lightGray
        return newPost
    }()
    
    lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "-OR-"
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.black)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.lightGray
        textView.text = "Add a description..."
        textView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 0.2
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupNewUserPostImageView()
        setupORLabel()
        setupCommentTextView()
    }
    
    private func setupNewUserPostImageView() {
        addSubview(newUserPostImageView)
        newUserPostImageView.translatesAutoresizingMaskIntoConstraints = false
        newUserPostImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        newUserPostImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        newUserPostImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.65).isActive = true
        newUserPostImageView.heightAnchor.constraint(equalTo: newUserPostImageView.widthAnchor).isActive = true
        
    }
    
    private func setupORLabel() {
        addSubview(orLabel)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.topAnchor.constraint(equalTo: newUserPostImageView.bottomAnchor, constant: 10).isActive = true
        orLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        orLabel.bottomAnchor.constraint(equalTo: commentTextView.topAnchor, constant: -10).isActive = true
    }
    
    private func setupCommentTextView() {
        addSubview(commentTextView)
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        commentTextView.widthAnchor.constraint(equalTo: newUserPostImageView.widthAnchor).isActive = true
        commentTextView.heightAnchor.constraint(equalTo: newUserPostImageView.heightAnchor).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
    }

}
