//
//  OrderMenu.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct OrderMenu: View{
    
    var body: some View{
        VStack{
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
                    Spacer()
                }
                
                ForEach(0 ..< 5) { _ in // Example: You can use a loop for multiple rows
                    HStack {
                        Text("Your Meal Name")
                        Spacer()
                        Text("$10.99")
                        Spacer()
                        Button(action: {
                            // Handle the + button action
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        .padding()
                        
                        TextField("Quantity", text: .constant("0"))
                            .keyboardType(.numberPad)
                            .frame(width: 50)
                        
                        Button(action: {
                            // Handle the - button action
                        }) {
                            Image(systemName: "minus.circle")
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                // Handle the checkout button action
            }) {
                Text("Checkout")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

struct OrderMenu_Previews: PreviewProvider {
    static var previews: some View {
        OrderMenu()
    }
}
