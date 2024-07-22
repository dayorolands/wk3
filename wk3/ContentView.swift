//
//  ContentView.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: {
                        DrawingScreen()
                    }, label: {
                        Label("Drawing screen", systemImage: "hand.draw")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.black)
                    })
                    .navigationTitle("Combined App")
                    NavigationLink {
                        RecordingView()
                    } label: {
                        Label("Audio screen", systemImage: "waveform.circle")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.black)
                    }
                }
            }
    
        }
    }
}

struct ContentView_Previe: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
