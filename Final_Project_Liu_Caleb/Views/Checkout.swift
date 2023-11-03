//
//  Checkout.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct Checkout: View{
        @State private var quantity = 1
        @State private var address = ""
        @State private var totalCost = 0.0
        @State private var isShowingConfirmationMenu = false
        @State private var isShowingOrderMenu = false
        @State private var isShowingLandingPage = false
        @State private var showCancelAlert = false

    var body: some View{
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("Meal Name")
                            .fontWeight(.bold)
                        Spacer()
                        Text("Price")
                            .fontWeight(.bold)
                        Spacer()
                        Text("Qty")
                            .fontWeight(.bold)
                            .padding(.horizontal, 30)
                    }
                    
                    HStack {
                        Text("Your Meal Name")
                        Spacer()
                        Text("$10.99")
                        Spacer()
                        
                        Button(action: {
                            // Handle the + button action
                            quantity += 1
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        .frame(width: 40, height: 40)
                        
                        TextField("Quantity", value: $quantity, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .frame(width: 20)
                        
                        Button(action: {
                            // Handle the - button action
                            if quantity > 0 {
                                quantity -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle")
                        }
                    }
                }.buttonStyle(BorderlessButtonStyle())
                
                Spacer()
                
                Text("Total Price: $\(String(format: "%.2f", Double(quantity) * 10.99))")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                
                TextField("Enter Your Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                NavigationLink("", destination: ConfirmationMenu(), isActive: $isShowingConfirmationMenu)
                
                NavigationLink("", destination: OrderMenu(), isActive: $isShowingOrderMenu)
                
                NavigationLink("", destination: LandingPage(), isActive: $isShowingLandingPage)
                                
                Button(action: {
                    isShowingConfirmationMenu = true
                    
                }) {
                    Text("Pay")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    showCancelAlert=true
                }) {
                    Text("Cancel Order")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showCancelAlert) {
                    Alert(title: Text("Cancel Order"), message: Text("Are you sure you want to cancel your order?"), primaryButton: .default(Text("Yes"), action: {
                        isShowingLandingPage = true
                    }), secondaryButton: .cancel(Text("No")))
                }
                
            }.navigationBarItems(leading:
                                    Button(action: {
                                        isShowingOrderMenu = true
                                    }) {
                                        Text("Back")
                                    }
                                )
        }.navigationBarHidden(true)
    }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout()
    }
}
