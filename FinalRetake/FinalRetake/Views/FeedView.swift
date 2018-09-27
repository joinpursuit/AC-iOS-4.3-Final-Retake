//
//  FeedView.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit

class FeedView: UIView {

    lazy var feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Post Cell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
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
        setupPostTableView()
    }
    
    private func setupPostTableView() {
        addSubview(feedTableView)
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        feedTableView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        feedTableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
