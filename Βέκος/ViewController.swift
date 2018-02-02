//
//  ViewController.swift
//  Βέκος
//
//  Created by Bhuvan on 02/02/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    let socket = SocketIOClient(socketURL: URL(string:"http://www.xn--nxagpuu.com/")!)
    
    @IBOutlet weak var bekosBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        socket.connect()
        bekosBut.center = self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bekosButPressed(_ sender: UIButton) {
        socket.emit("BEKOS", "asnee")
        print("emmitted")
        
    }

}

