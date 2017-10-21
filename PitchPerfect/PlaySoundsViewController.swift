//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Lakshmikanth H on 4/4/17.
//  Copyright © 2017 lakshmikantha. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @objc var recordedAudioURL: URL!
    @objc var audioFile:AVAudioFile!
    @objc var audioEngine:AVAudioEngine!
    @objc var audioPlayerNode: AVAudioPlayerNode!
    @objc var stopTimer: Timer!
    
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        //Select the sound to play based on the button clicked
        switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        //Stop Audio if stopButton id Pressed
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        vaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit

        setupAudio()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
