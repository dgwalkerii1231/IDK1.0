//
//  ViewController.swift
//  IDK1.0
//
//  Created by Danny Walker on 10/31/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

