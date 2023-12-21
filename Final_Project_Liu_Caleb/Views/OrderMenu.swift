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
    @State private var isShowingLandingPage = false
    @State private var isShowingCheckout = false
    @ObservedObject var viewModel: RestaurantManagementViewModel
    @State private var showAlert = false

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

                    ForEach(viewModel.mealList) { meal in
                        HStack {
                            Text(meal.name)
                            Spacer()
                            Text(String(describing: meal.price))
                            Spacer()

                                Button(action: {
                                    // Handle the + button action
                                    if let mealID = meal.id {
                                                                        if let quantity = viewModel.mealQuantities[mealID] {
                                                                            viewModel.mealQuantities[mealID] = quantity + 1
                                                                        } else {
                                                                            viewModel.mealQuantities[mealID] = 1
                                                                        }
                                                                    } else {
                                        print("Error: Invalid meal ID")
                                    }
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
                                                                    if let mealID = meal.id {
                                                                        if let quantity = viewModel.mealQuantities[mealID] {
                                                                            return String(quantity)
                                                                        }
                                    }
                                    return ""
                                },
                                set: { newValue in
                                    if let mealID = meal.id {
                                        // Assuming mealID is a string
                                        if let quantity = Int(newValue) {
                                            viewModel.mealQuantities[mealID] = quantity
                                        } else {
                                            print("Invalid quantity: \(newValue)")
                                            viewModel.mealQuantities[mealID] = 0
                                        }
                                    }
                                }
                            ))

                                .keyboardType(.numberPad)
                                .frame(width: 20)

                            Button(action: {
                                // Handle the - button action
                                if let mealID = meal.id {
                                                                    if let quantity = viewModel.mealQuantities[mealID], quantity > 0 {
                                                                        viewModel.mealQuantities[mealID] = quantity - 1
                                                                    }
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

                NavigationLink(destination: Checkout(viewModel: viewModel), isActive: $isShowingCheckout) {
                    Text("Checkout")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 27)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    // Check if all quantities are greater than 0
                    if viewModel.mealQuantities.values.contains(where:{ $0 > 0 }) {
                        // All quantities are greater than 0, proceed to Checkout
                        viewModel.sendMealsToCheckout()
                        isShowingCheckout = true
                    } else {
                        showAlert = true
                    }
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Cannot Process to Checkout"),
                        message: Text("Please ensure that the quantities for all meals are greater than 0."),
                        dismissButton: .default(Text("OK"))
                    )
                }

                
                NavigationLink("", destination: LandingPage(viewModel: viewModel), isActive: $isShowingLandingPage)
                
                
            }.navigationBarItems(leading:
                Button(action: {
                    viewModel.clear()
                    isShowingLandingPage = true

                    }) {
                        Text("Home")
                        }
                )}
        .navigationBarHidden(true)
    }
}
