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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedView)
    }

}
