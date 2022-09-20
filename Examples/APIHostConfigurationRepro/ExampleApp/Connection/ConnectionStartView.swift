//
//  ConnectionStartView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

struct ConnectionStartView: View {
    @EnvironmentObject var appState: AppState
    @State var token: String = ""
    @State var connectError: String = ""
    @State var connectSuccess: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Enter your device token")
                    .padding()
                    .padding(.bottom, 10)
                TextField("Token", text: $token)
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                Button(action: {
                    let connected = appState.connectDevice(token: token)
                    if (!connected) {
                        connectError = "Unable to connect device"
                        connectSuccess = false
                    } else {
                        connectError = ""
                        connectSuccess = true
                    }
                }) {
                    Text("Connect!")
                }
                    .padding(.bottom, 10)
                Text(connectError)
                    .padding()
                    .foregroundColor(Color(.systemRed))
                
            }
            .padding()
        }
        .navigationTitle("Connection Start")
        .background(
            NavigationLink(destination: ConnectionSuccessView(), isActive: $connectSuccess) {
                EmptyView()
            }
            .hidden()
        )
    }
}

struct ConnectionStartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConnectionStartView()
        }
    }
}
