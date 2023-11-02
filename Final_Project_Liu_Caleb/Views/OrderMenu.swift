//
//  OrderMenu.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct NonRespondingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture { } // Prevent the list item from responding to taps
    }
}

struct OrderMenu: View {
    @State private var mealQuantities: [Int] = Array(repeating: 0, count: 5)

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

                                }) {
                                    Image(systemName: "plus.circle")
                                        .background(Color.clear)
                                        .contentShape(Rectangle())

                                }
                                .frame(width: 40, height: 40)
                                .background(Color.clear)
                                .zIndex(1)

                                TextField("Quantity", text: Binding(
                                    get: {
                                        String(mealQuantities[index])
                                    },
                                    set: { newValue in
                                            if let quantity = Int(newValue) {
                                                mealQuantities[index] = quantity
                                            } else {
                                                print("Invalid quantity: \(newValue)")
                                                mealQuantities[index]=0
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
                                        .background(Color.clear)
                                        .contentShape(Rectangle())
                                }
                                .frame(width: 40, height: 40)
                                .background(Color.clear)
                            }
                        
                    }.buttonStyle(BorderlessButtonStyle())
                }

                NavigationLink(destination: Checkout()) {
                    Text("Checkout")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 27)
                }
            }
        }
        .navigationBarHidden(true)
    }
}


struct OrderMenu_Previews: PreviewProvider {
    static var previews: some View {
        OrderMenu()
    }
}
