//
//  ContentView.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var websocketViewModel = WebsocketViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter Message", text: $websocketViewModel.sentMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                websocketViewModel.sendMessage()
                self.hideKeyboard()
            }) {
                Text("Send Message")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
            
            Text("Received Message")
                .font(.headline)
                .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(websocketViewModel.receivedMessage, id: \.self) { message in
                        Text(message)
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .onAppear {
            websocketViewModel.setupWebSocket()
            websocketViewModel.ping()
        }
        .onDisappear {
            websocketViewModel.closeWebsocket()
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
