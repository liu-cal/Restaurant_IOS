//
//  ConfirmationMenu.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct ConfirmationMenu: View{
    @State private var showKeepShoppingAlert = false
        @State private var showLogoutAlert = false
    
    var body: some View{
        VStack{
            Spacer()
                        
                        Text("Thank you for ordering at Liu's Restaurant!")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("Total Cost: $100.00")
                            .font(.headline)
                            .padding(.top, 20)
                        
                        Text("Estimated Delivery Time: 30 minutes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            // Handle Keep Shopping action
                            showKeepShoppingAlert = true
                        }) {
                            Text("Keep Shopping")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .alert(isPresented: $showKeepShoppingAlert) {
                            Alert(title: Text("Keep Shopping"), message: Text("Continue shopping at Liu's Restaurant?"), primaryButton: .default(Text("Yes")), secondaryButton: .cancel(Text("No")))
                        }
                        
                        Button(action: {
                            // Handle Log Out action
                            showLogoutAlert = true
                        }) {
                            Text("Log Out")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        .alert(isPresented: $showLogoutAlert) {
                            Alert(title: Text("Log Out"), message: Text("Are you sure you want to log out?"), primaryButton: .default(Text("Yes")), secondaryButton: .cancel(Text("No")))
                        }
        }
        .background(
            Image("restaurant_2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ConfirmationMenu_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationMenu()
    }
}
