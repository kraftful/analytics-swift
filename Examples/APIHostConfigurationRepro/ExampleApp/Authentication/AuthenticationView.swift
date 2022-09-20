//
//  AuthenticationView.swift
//  ExampleApp
//
//  Created by Jacob Gable on 6/16/22.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
