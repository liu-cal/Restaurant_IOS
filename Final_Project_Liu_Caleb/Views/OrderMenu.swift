//
//  OrderMenu.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct OrderMenu: View {
    @State private var mealQuantities: [Int] = Array(repeating: 0, count: 5)
// Initialize an array to store quantities
    
    var body: some View {
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
                        Spacer()
                    }
                    
                    ForEach(0 ..< 5, id: \.self) { index in
                                            HStack {
                                                Text("Your Meal Name")
                                                Spacer()
                                                Text("$10.99")
                                                Spacer()
                                                
                                                Button(action: {
                                                    // Handle the + button action
                                                    mealQuantities[index] += 1
                                                    
                                                    print(mealQuantities)
                                                }) {
                                                    Image(systemName: "plus.circle")
                                                }
                                                .padding().zIndex(999)

                                                TextField("Quantity", text: Binding(
                                                    get: {
                                                        String(mealQuantities[index])
                                                    },
                                                    set: { newValue in
                                                        if let quantity = Int(newValue) {
                                                            mealQuantities[index] = quantity
                                                        }
                                                    }
                                                ))
                                                .keyboardType(.numberPad)
                                                .frame(width: 50)

                                                Button(action: {
                                                    // Handle the - button action
                                                    if mealQuantities[index] > 0 {
                                                        mealQuantities[index] -= 1
                                                    }
                                                }) {
                                                    Image(systemName: "minus.circle")
                                                }
                                            }
                                        }
                                    }
                
                Spacer()
                
                NavigationLink(destination: Checkout()) {
                    Text("Checkout")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }.navigationBarHidden(true)
    }
}

struct OrderMenu_Previews: PreviewProvider {
    static var previews: some View {
        OrderMenu()
    }
}
