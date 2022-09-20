//
//  ConnectionSuccessView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

struct ConnectionSuccessView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Successfully connected your device")
                    .padding()
                    .padding(.bottom, 10)
                Button(action: {
                    appState.markDeviceReady()
                }) {
                    Text("Continue")
                }
            }
        }
        .navigationTitle("Connection Success")
    }
}

struct ConnectionSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConnectionSuccessView()
        }
    }
}
