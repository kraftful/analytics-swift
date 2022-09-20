//
//  AppState.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import Foundation

var TEST_USER_EMAIL = "test@test.com"
var TEST_USER_PASSWORD = "test1234"
var TEST_USER_ID = "12345"
var TEST_DEVICE_CONNECT_TOKEN = "123abc"

// Serializable version of state data
struct AppStateData: Codable {
    var loggedIn: Bool
    var loggedInUserId: String
    var deviceConnected: Bool
    var deviceReady: Bool
    var deviceCurrentTemp: Double
    var deviceModes = ["Cool", "Heat", "Off"]
    var deviceMode: String
    var deviceSetpoint: Double
    
    init() {
        self.loggedIn = false
        self.loggedInUserId = ""
        self.deviceConnected = false
        self.deviceReady = false
        self.deviceCurrentTemp = 75
        self.deviceMode = "Cool"
        self.deviceSetpoint = 72
    }
}

// Observable state data/methods and persistence statics
class AppState: ObservableObject {
    @Published var loggedIn: Bool
    @Published var loggedInUserId: String
    @Published var deviceConnected: Bool
    @Published var deviceReady: Bool
    @Published var deviceCurrentTemp: Double
    @Published var deviceModes = ["Cool", "Heat", "Off"]
    @Published var deviceMode: String
    @Published var deviceSetpoint: Double
    
    init() {
        self.loggedIn = false
        self.loggedInUserId = ""
        self.deviceConnected = false
        self.deviceReady = false
        self.deviceCurrentTemp = 75
        self.deviceMode = "Cool"
        self.deviceSetpoint = 72
    }
    
    func signIn(username: String, password: String) -> Bool {
        if (username == TEST_USER_EMAIL && password == TEST_USER_PASSWORD) {
            self.loggedIn = true
            self.loggedInUserId = TEST_USER_ID
        } else {
            self.loggedIn = false
            self.loggedInUserId = ""
        }
        
        return self.loggedIn
    }
    
    func register(username: String, password: String) -> Bool {
        if (username == TEST_USER_EMAIL && password == TEST_USER_PASSWORD) {
            self.loggedIn = true
            self.loggedInUserId = TEST_USER_ID
        } else {
            self.loggedIn = false
            self.loggedInUserId = ""
        }
        
        return self.loggedIn
    }
    
    func connectDevice(token: String) -> Bool {
        self.deviceConnected = token.lowercased() == TEST_DEVICE_CONNECT_TOKEN
        
        return self.deviceConnected
    }
    
    func markDeviceReady() {
        self.deviceReady = true
    }
    
    func changeSetpoint(increment: Double) {
        self.deviceSetpoint += increment
    }
    
    func logout() {
        self.loggedIn = false
        self.loggedInUserId = ""
        self.deviceConnected = false
        self.deviceReady = false
        self.deviceCurrentTemp = 75
        self.deviceMode = "Cool"
        self.deviceSetpoint = 72
    }
    
    // Persistence helpers
    
    func fromData(data: AppStateData) {
        self.loggedIn = data.loggedIn
        self.loggedInUserId = data.loggedInUserId
        self.deviceConnected = data.deviceConnected
        self.deviceReady = data.deviceReady
        self.deviceCurrentTemp = data.deviceCurrentTemp
        self.deviceMode = data.deviceMode
        self.deviceSetpoint = data.deviceSetpoint
    }
    
    func toData() -> AppStateData {
        var data = AppStateData()
        data.loggedIn = self.loggedIn
        data.loggedInUserId = self.loggedInUserId
        data.deviceConnected = self.deviceConnected
        data.deviceReady = self.deviceReady
        data.deviceCurrentTemp = self.deviceCurrentTemp
        data.deviceMode = self.deviceMode
        data.deviceSetpoint = self.deviceSetpoint
        
        return data
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("appstate.data")
    }

    static func load(completion: @escaping (Result<AppStateData, Error>)->Void) {
        let _ = print("Loading state")
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(AppStateData()))
                    }
                    return
                }
                let decodedAppState = try JSONDecoder().decode(AppStateData.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(decodedAppState))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    static func save(state: AppStateData, completion: @escaping (Result<Bool, Error>)->Void) {
        let _ = print("Saving state")
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(state)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
