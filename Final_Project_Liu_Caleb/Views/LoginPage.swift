//
//  LoginPage.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct LoginPage: View {
    @State private var username = ""
    @State private var password = ""
    @ObservedObject var viewModel = RestaurantManagementViewModel()

    @State private var loginSuccessful = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.login(username: username, password: password) { success in
                                            if success {
                                                // Navigate to LandingPage
                                                loginSuccessful = true
                                            } else {
                                                // Stay on the same page or show an error message
                                                // For simplicity, let's just print an error message
                                                print("Login failed. Stay on the same page or show an error message.")
                                            }
                                        }
                }) {
                    Text("Log In")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Login")
            .navigationBarItems(trailing:
                NavigationLink(destination: SignUpPage()) {
                    Text("Sign Up")
                }
            )
            .background(
                NavigationLink("", destination: LandingPage(viewModel: viewModel), isActive: $loginSuccessful)
            )
        }
        .navigationBarHidden(true)
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
