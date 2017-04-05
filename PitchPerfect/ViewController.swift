//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Lakshmikanth H on 4/4/17.
//  Copyright © 2017 lakshmikantha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recoring in Progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
    }

}

