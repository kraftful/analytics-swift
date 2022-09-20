//
//  HomeDeviceView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

struct HomeDeviceView: View {
    @EnvironmentObject var appState: AppState
    let formatter: NumberFormatter = NumberFormatter()
    let modes = ["Cool", "Heat", "Off"]
    
    init() {
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("Current Temp")
                        .padding(.bottom, 10)
                    Text("\(formatter.string(from: appState.deviceCurrentTemp as NSNumber) ?? "?")°")
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .font(.largeTitle)
                }.padding(.bottom, 20)
                
                VStack {
                    Text("Setpoint")
                        .padding(.bottom, 10)
                    HStack {
                        Button(action: {
                            appState.changeSetpoint(increment: -1)
                        }) {
                            Text("-")
                                .font(.largeTitle)
                                .padding(.bottom, 12)
                                .padding(.trailing, 20)
                        }
                        Text("\(formatter.string(from: appState.deviceSetpoint as NSNumber) ?? "?")°")
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                            .font(.largeTitle)
                            .frame(width: 100, alignment: .center)
                        Button(action: {
                            appState.changeSetpoint(increment: 1)
                        }) {
                            Text("+")
                                .font(.largeTitle)
                                .padding(.bottom, 12)
                                .padding(.leading, 20)
                        }
                    }
                }.padding(.bottom, 20)
                
                VStack {
                    Text("Mode")
                        .padding(.bottom, 10)
                    Picker("Mode", selection: $appState.deviceMode) {
                        ForEach(appState.deviceModes, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Home")
        .navigationBarItems(
            leading: Button(action: {
                appState.logout()
            }) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("Logout")
                }
            },
            trailing: NavigationLink(
                destination: HomeSettingsView(),
                label: {
                    Image(systemName: "gear")
                }
            )
        )
    }
}

struct HomeDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeDeviceView()
                .environmentObject(AppState())
        }
    }
}
