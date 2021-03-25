//
//  ViewController.swift
//  SpaceInvaders
//
//  Created by Admin on 06.03.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func PlayButtonPressed(_ sender: UIButton) {
        let inGameViewController : InGameViewController = InGameViewController()
        show(inGameViewController, sender: self)
        
    }
}

