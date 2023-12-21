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
    @State private var enablePayButton = false
    @ObservedObject var viewModel: RestaurantManagementViewModel
    @State private var showEmptyAddressAlert=true
    
    var body: some View{
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("Meal Name")
                            .fontWeight(.bold)

                        Spacer()
                        Text("Qty")
                            .fontWeight(.bold)
                            .padding(.horizontal, 30)
                    }
                    
                    ForEach(viewModel.orderList) { order in
                                            HStack {
                                                Text(order.mealName)
                                                Spacer()
                                                Text(order.quantity)
                                            }
                                        }
                }.buttonStyle(BorderlessButtonStyle())
                
                Spacer()
                
                Text("Total Price: $\(viewModel.totalCost)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                
                TextField("Enter Your Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .onChange(of: address) { newValue in
                            enablePayButton = !newValue.isEmpty
                        }
                
                NavigationLink("", destination: ConfirmationMenu(viewModel: viewModel), isActive: $isShowingConfirmationMenu)
                
                NavigationLink("", destination: OrderMenu(viewModel: viewModel), isActive: $isShowingOrderMenu)
                
                NavigationLink("", destination: LandingPage(viewModel: viewModel), isActive: $isShowingLandingPage)
                                
                Button(action: {
                    if enablePayButton{
                        // Call the viewModel function to update the delivery information
                        viewModel.confirmOrderClicked(deliveryAddress: address)
                        
                        // Proceed to the Confirmation Menu page
                        isShowingConfirmationMenu = true
                    } else {
                        // Show an alert if the address is empty and pay button is pressed
                        showEmptyAddressAlert = true
                    }
                }) {
                    Text("Pay")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .alert(isPresented: Binding(
                    get: { showEmptyAddressAlert },
                    set: { newValue in showEmptyAddressAlert = newValue }
                ))  {
                    Alert(title: Text("Address is Empty"), message: Text("Please enter your address before proceeding."), dismissButton: .default(Text("OK")))
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
                        viewModel.clear()

                        isShowingLandingPage = true
                    }), secondaryButton: .cancel(Text("No")))
                }
                
            }.navigationBarItems(leading:
                Button(action: {
                    viewModel.orderList=[]
                
                    isShowingOrderMenu = true
                }) {
                    Text("Back")
                })
        }.navigationBarHidden(true)
    }
}
