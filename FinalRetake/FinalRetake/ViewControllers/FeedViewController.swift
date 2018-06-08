//
//  FeedViewController.swift
//  FinalRetake
//
//  Created by Maryann Yin on 6/7/18.
//  Copyright © 2018 Maryann Yin. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    let firebaseAuthService = FirebaseAuthService()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.feedTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedView)
        firebaseAuthService.delegate = self
        feedView.feedTableView.delegate = self
        feedView.feedTableView.dataSource = self
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FirebaseAuthService.getCurrentUser() == nil {
            let loginVC = LoginViewController()
            present(loginVC, animated: false, completion: nil)
        } else {
            DBService.manager.loadAllPosts(completionHandler: { (DBPosts) in
                if let DBPosts = DBPosts { self.posts = DBPosts }
                else { self.showAlert(title: "Error", message: "Unable to Load Posts") }
            })
        }
    }
    
    private func setupNavBar() {
        navigationItem.title = "Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logout))
    }
    
    @objc private func logout() {
        let alertView = UIAlertController(title: "Logging Out?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let yesOption = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive) { (alertAction) in
            self.firebaseAuthService.signOut()
            let loginVC = LoginViewController()
            self.present(loginVC, animated: true)
        }
        let noOption = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension FeedViewController: FirebaseAuthServiceDelegate {
    
    func didSignOut(_authService: FirebaseAuthService) {
        self.posts.removeAll()
    }
    
    func didFailSignOut(_authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if posts.count > 0 {
            feedView.feedTableView.backgroundView = nil
            feedView.feedTableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: feedView.feedTableView.bounds.size.width, height: feedView.feedTableView.bounds.size.height))
            noDataLabel.text = "No posts yet!"
            noDataLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
            noDataLabel.textAlignment = .center
            feedView.feedTableView.backgroundView = noDataLabel
            feedView.feedTableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostTableViewCell
        let selectedPost = posts.reversed()[indexPath.row]
        postCell.configureCell(post: selectedPost)
        return postCell
    }
    
}

extension FeedViewController: UITableViewDelegate { }
