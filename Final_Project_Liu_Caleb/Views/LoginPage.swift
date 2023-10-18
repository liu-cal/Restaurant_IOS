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
                    // Add your login logic here
                    // You can check the entered username and password
                    // If login is successful, navigate to the next view
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
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}