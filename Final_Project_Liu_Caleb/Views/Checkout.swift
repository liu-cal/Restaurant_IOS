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
    
    var body: some View{
        VStack {
                    List {
                        HStack {
                            Text("Meal Name")
                                .fontWeight(.bold)
                            Text("Price")
                                .fontWeight(.bold)
                            Spacer()
                            Text("Qty")
                                .fontWeight(.bold)
                            Spacer()
                            EmptyView()
                                .frame(width: 30) // Empty grid space
                        }
                        
                        HStack {
                            Text("Your Meal Name")
                            Text("$10.99")
                            Spacer()
                            Button(action: {
                                // Handle the + button action
                                quantity += 1
                            }) {
                                Image(systemName: "plus.circle")
                            }
                            .padding()
                            
                            TextField("Quantity", value: $quantity, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 50)
                            
                            Button(action: {
                                // Handle the - button action
                                if quantity > 1 {
                                    quantity -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle")
                            }
                        }
                    }
                    
                    Spacer()
                    
            Text("Total Price: $\(String(format: "%.2f", Double(quantity) * 10.99))")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        
                        TextField("Enter Your Address", text: $address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            // Handle the calculate total cost action
                            totalCost = Double(quantity) * 10.99
                        }) {
                            Text("Calculate Total Cost")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 250, height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle the payment action
                            // You can implement payment logic here
                        }) {
                            Text("Pay")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            // Handle the order cancellation action
                            // You can implement cancellation logic here
                        }) {
                            Text("Cancel Order")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                }
    }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout()
    }
}
