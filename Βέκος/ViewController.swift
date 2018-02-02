//
//  ViewController.swift
//  Βέκος
//
//  Created by Bhuvan on 02/02/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bekosBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bekosButPressed(_ sender: UIButton) {
        print("yey")
        
    }

}

