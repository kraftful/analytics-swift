//
//  ExampleAppApp.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

@main
struct ExampleAppApp: App {
    @StateObject private var state = AppState()
    @Environment(\.scenePhase) private var scenePhase
  
    init() {
      SegmentAnalytics.initialize(writeKey: "hjBKMDIweAchbXnzrP4PL3gVJ5ZmVEWt")
    }
    
    var body: some Scene {
      WindowGroup {
            ContentView()
              .onAppear {
                // Load when foregrounded
                AppState.load { result in
                  switch result {
                  case .failure(let error):
                      fatalError(error.localizedDescription)
                  case .success(let data):
                    state.fromData(data: data)
                  }
                }
              }
              .onChange(of: scenePhase) { phase in
                // Save when backgrounded
                if phase == .inactive {
                  AppState.save(state: state.toData()) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                  }
                }
              }
              .environmentObject(state)
        }
    }
}
