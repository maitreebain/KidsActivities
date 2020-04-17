//
//  ViewController.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/14/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth

class OptionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }

    @IBAction func activity1(_ sender: UIButton) {
    }
    
    
    @IBAction func activity6(_ sender: UIButton) {
    }
    
    
    @IBAction func activity10(_ sender: UIButton) {
    }
    
    @IBAction func activity17(_ sender: UIButton) {
        let letterVC = LetterViewController()
        self.navigationController?.pushViewController(letterVC, animated: true)
    }
    
    @IBAction func activity20(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Scavenger", bundle: nil)
        let scavVC = storyboard.instantiateViewController(identifier: "ScavengerViewController") as ScavengerViewController
        self.navigationController?.pushViewController(scavVC, animated: true)
    }
}
