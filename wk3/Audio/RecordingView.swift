//
//  TimerView.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/22/24.
//

import SwiftUI

struct RecordingView: View {
    @StateObject private var audioRecorder = AudioRecoder()
    
    var body: some View {
        VStack {
            if audioRecorder.isRecording {
                Button("Stop Recording") {
                    audioRecorder.stopRecording()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Start Recording") {
                    audioRecorder.startRecording()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            if audioRecorder.isPlaying {
                Button("Stop Playback") {
                    audioRecorder.stopPlayback()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top, 20)
            } else {
                Button("Play Recording") {
                    audioRecorder.startPlayback()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top, 20)
            }
            
            Text("Volume: \(audioRecorder.volume, specifier: "%.2f")")
                .padding(.top, 20)
        }
        .padding()
    }
}

struct RecodingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
