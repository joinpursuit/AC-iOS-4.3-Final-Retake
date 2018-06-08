//
//  PostTableViewCell.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder_image")
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var postCommentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    lazy var timeStampLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "Post Cell")
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
        setupPostImageView()
        setupPostCommentLabel()
        setupEmailLabel()
        setupTimeStampLabel()
    }
    
    private func setupEmailLabel() {
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.35)
        emailLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    private func setupTimeStampLabel() {
        addSubview(timeStampLabel)
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStampLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 3).isActive = true
        timeStampLabel.widthAnchor.constraint(equalTo: emailLabel.widthAnchor).isActive = true
        
    }
    
    private func setupPostImageView() {
        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        postImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 5).isActive = true
        postImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6).isActive = true
        postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor).isActive = true
    }
    
    private func setupPostCommentLabel() {
        addSubview(postCommentLabel)
        postCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        postCommentLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        postCommentLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        postCommentLabel.widthAnchor.constraint(equalTo: postImageView.widthAnchor).isActive = true
        postCommentLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    public func configureCell(post: Post) {
        styleCell()
        emailLabel.text = post.userEmail
        timeStampLabel.text = post.postTimeAndDateStamp
        postCommentLabel.text = post.comment
        postImageView.kf.setImage(with: URL(string: post.postImageURL), placeholder: #imageLiteral(resourceName: "placeholder_image"), options: nil, progressBlock: nil) { (image, error, cache, url) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func styleCell() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width:0.0, height: 3.0)
        layer.shadowOpacity = 1.0
    }

}
