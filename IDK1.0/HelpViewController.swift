//
//  HelpViewController.swift
//  IDK1.0
//
//  Created by Danny Walker on 11/8/20.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */    
}
