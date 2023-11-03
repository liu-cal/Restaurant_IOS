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
    @State private var isShowingOrderMenu = false
    @State private var isShowingLoginPage = false
    
    var body: some View{
        NavigationView{
            ZStack{
                Image("restaurant_2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    Text("Thank you for ordering at Liu's Restaurant!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 350)
                    Spacer()
                    Text("Total Cost: $100.00")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text("Estimated Delivery Time: 30 minutes")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    NavigationLink("", destination: OrderMenu(), isActive: $isShowingOrderMenu)
                    
                    NavigationLink("", destination: LoginPage(), isActive: $isShowingLoginPage)
                    
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
                        Alert(title: Text("Keep Shopping"), message: Text("Continue shopping at Liu's Restaurant?"), primaryButton: .default(Text("Yes"), action: {
                            isShowingOrderMenu = true
                        }), secondaryButton: .cancel(Text("No")))
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
                        Alert(title: Text("Log Out"), message: Text("Are you sure you want to log out?"), primaryButton: .default(Text("Yes"), action: {
                            isShowingLoginPage=true
                        }), secondaryButton: .cancel(Text("No")))
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ConfirmationMenu_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationMenu()
    }
}
