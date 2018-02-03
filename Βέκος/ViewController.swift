//
//  ViewController.swift
//  Βέκος
//
//  Created by Bhuvan on 02/02/2018.
//  Copyright © 2018 bhuvan21. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    let socket = SocketIOClient(socketURL: URL(string:"http://www.xn--nxagpuu.com/")!)
    
    let url = NSURL(string: "http://www.xn--nxagpuu.com/audio?format=json")
    
    var player:AVPlayer?

    
    var sounds : [AVPlayerItem] = []
    var sound_urls : [URL] = []
    
    var audio_json : JSON = []
    
    var beekos : JSON = []
    
    @IBOutlet weak var bekosBut: UIButton!
    
    @IBOutlet weak var latestBek: UILabel!
    
    @IBOutlet weak var bekID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        socket.connect()
        
        
        bekosBut.center = self.view.center
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.bekID.delegate = self;

        socket.on("BEEKOS") {data, ack in
            print("emmitted")
            self.beekos = JSON(data)
            self.latestBek.text = self.beekos[0]["message"].description
            
            self.play(url: self.sound_urls[Int(self.beekos[0]["sound"].description)!])
            
            //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
        update_sounds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bekosButPressed(_ sender: UIButton) {
        socket.emit("BEKOS", bekID.text!)
    }
    

    func json_request(){
        if let url = URL(string: "http://www.xn--nxagpuu.com/audio?format=json") {
            do {
                let contents = try String(contentsOf: url)
                try self.audio_json = JSON(data: contents.data(using: String.Encoding.utf8)!)
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    
    func update_sounds(){
        json_request()
        print(self.audio_json)
        print(self.audio_json[0])
        let url = URL(string:"http://www.xn--nxagpuu.com/" + String(describing: self.audio_json[0]))
        print(url!)
        
        for i in 0 ..< self.audio_json.count  {
            let url = URL(string:"http://www.xn--nxagpuu.com/" + String(describing: self.audio_json[i]))
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            self.sounds.append(playerItem)
            self.sound_urls.append(url!)
        }
    }
    
    
    func play(url:URL) {
        print("playing \(url)")
        do {
            let playerItem = AVPlayerItem(url: url)
    
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return false
    }
    
}



