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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(uploadView)
    }

}
