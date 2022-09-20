//
//  RegisterView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @State var username: String = ""
    @State var password: String = ""
    @State var registerError: String = ""
    let lightGray: Color = Color(red: 0.9, green: 0.9, blue:  0.9)
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Enter account information")
                    .padding(.bottom, 10)
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 5)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                Button(action: {
                    let success = appState.register(username: username, password: password)
                    if (!success) {
                        registerError = "Unable to register with those credentials"
                    } else {
                        registerError = ""
                    }
                }) {
                    Text("Register!")
                }
                    .padding(.bottom, 10)
                Text(registerError)
                    .foregroundColor(Color(.systemRed))
            }.padding()
        }
        .navigationTitle("Register")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
        }
    }
}
