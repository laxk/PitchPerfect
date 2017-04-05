//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Lakshmikanth H on 4/4/17.
//  Copyright © 2017 lakshmikantha. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //Class RecordSoundsViewController inherits from UIViewController and conforms to AVAudioRecorderDelegate protocol
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable stopRecordingButton when the view loads first time.
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        //Disable recordButton and enable stopRecordingButton and change the label appropriately
        enableRecordingButtons(recording: true)
        
        //Name the file to be saved and specify the path to save the recorded file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        //Start AVAudiSession and set the required parameters to record the audio
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        //Enable recordButton and disable stopRecordingButton and change the label appropriately
        enableRecordingButtons(recording: false)
        //Stop th eaudio recording and the AVAudioSession
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    
    func enableRecordingButtons(recording: Bool) {
        //Method to control the recordingLabel, stopRecordingButton, recordButton
        recordingLabel.text = recording ? "Recording in progress" : "Tap to Record"
        stopRecordingButton.isEnabled = recording
        recordButton.isEnabled = !recording
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        if flag {
            //When stopRecording button is pressed and if audio is recorded successfully, perform segue to PlaySoundsViewController
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

