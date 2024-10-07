//
//  VolumeObserver.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/22/24.
//

import Foundation
import MediaPlayer
import Combine

class VolumeObserver: ObservableObject {
    private var volumeView: MPVolumeView!
    private var cancellable: AnyCancellable?
    
    @Published var systemVolume: Float = AVAudioSession.sharedInstance().outputVolume
    
    init() {
        setupVolumeView()
        setupVolumeObserver()
    }
    
    private func setupVolumeView(){
        volumeView = MPVolumeView(frame: .zero)
        volumeView?.isHidden = true
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.addSubview(volumeView)
        }
    }
    
    private func setupVolumeObserver() {
        cancellable = AVAudioSession.sharedInstance().publisher(for: \.outputVolume)
            .receive(on: RunLoop.main)
            .sink { [weak self] volume in
                self?.systemVolume = volume
            }
    }
}
