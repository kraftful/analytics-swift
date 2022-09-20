//
//  SignInView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    @State var username: String = ""
    @State var password: String = ""
    @State var loginError: String = ""
    let lightGray: Color = Color(red: 0.95, green: 0.95, blue:  0.95)
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome")
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
                    let success = appState.signIn(username: username, password: password)
                    if (!success) {
                        SegmentAnalytics.track(event: "Sign In Failure")
                        loginError = "Unable to login with those credentials"
                    } else {
                        SegmentAnalytics.track(event: "Sign In Success")
                        loginError = ""
                    }
                }) {
                    Text("Login!")
                }
                    .padding(.bottom, 10)
                NavigationLink("Create Account", destination: RegisterView())
                    .padding(.bottom, 10)
                Text(loginError)
                    .foregroundColor(Color(.systemRed))
            }.padding()
        }
        .onAppear() {
          SegmentAnalytics.track(event: "Sign In Start")
        }
        .navigationTitle("Sign In")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView()
        }
        .previewDevice("iPhone 13 Pro")
        
    }
}
