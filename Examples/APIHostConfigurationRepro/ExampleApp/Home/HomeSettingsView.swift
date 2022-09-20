//
//  HomeSettingsView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/17/22.
//

import SwiftUI

struct HomeSettingsView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        Form {
            Section(header: Text("ABOUT")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0-Example")
                }
            }
          
            Section {
              Button(action: {
                appState.logout()
              }) {
                Text("Logout")
              }
            }
        }
        .navigationTitle("Settings")
    }
}

struct HomeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeSettingsView()
        }
    }
}
