//
//  SignUpPage.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct SignUpPage: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isShowingLoginPage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                NavigationLink("", destination: LoginPage(), isActive: $isShowingLoginPage)
                
                Button(action: {
                    isShowingLoginPage = true
                }) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationBarTitle("Sign Up")
            .navigationBarItems(leading:
                Button(action: {
                    isShowingLoginPage = true

                }) {
                    Text("Back")
                }
            )
        }.navigationBarHidden(true)
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
