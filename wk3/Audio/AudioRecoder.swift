//
//  AudioPlayer.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/22/24.
//

import Foundation
import AVFoundation
import Combine

class AudioRecoder: NSObject, ObservableObject, AVAudioPlayerDelegate{
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    @Published var isRecording = false
    @Published var isPlaying = false
    @Published var volume: Float = AVAudioSession.sharedInstance().outputVolume
    
    private var volumeObserver: VolumeObserver
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        volumeObserver = VolumeObserver()
        super.init()
        setupVolumeObserver()
    }
    
    private func setupVolumeObserver() {
        volumeObserver.$systemVolume
            .sink { [weak self] volume in
                self?.volume = volume
                self?.audioPlayer?.volume = volume
            }
            .store(in: &cancellables)
    }
    
    let recordingUrl: URL = {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("recording.m4a")
    }()
    
    func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: recordingUrl, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Failed to set up the recorder", error)
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        audioRecorder = nil
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: recordingUrl.path) {
            print("Recording file exists at path: \(recordingUrl.path)")
        } else {
            print("Recording file does not exist at path: \(recordingUrl.path)")
        }
    }
    
    func startPlayback() {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: recordingUrl.path) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: recordingUrl)
                audioPlayer?.volume = volume
                audioPlayer?.play()
                isPlaying = true
                audioPlayer?.delegate = self
            } catch {
                print("Failed to set up the player:", error)
            }
        } else {
            print("Recoding file does not exist at path: \(recordingUrl.path)")
        }
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}

extension AudioRecoder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully")
        } else {
            print("Recording failed.")
        }
    }
}
