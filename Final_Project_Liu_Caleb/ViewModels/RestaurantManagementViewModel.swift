//
//  MealNumHandler.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import Combine
import Foundation

final class RestaurantManagementViewModel: ObservableObject{
    @Published var restoRepo = RestaurantRepository.shared
    @Published var mealList: [Meal] = []
    @Published var orderList: [Order]=[]
    @Published var mealQuantities: [String: Int] = [:]
    @Published var name: String = ""
    @Published var newDelivery = Delivery(address: "", deliveryTime: "", totalCost:0.0)
    private var cancellables: Set<AnyCancellable> = []
    
    //calculates total cost with tax
    var totalCost: String {
        let subtotal = orderList.reduce(Decimal(0.0)) { (result, order) in
            var result = result
            
            if let mealId = order.id,
               let mealQuantity = mealQuantities[mealId],
               let meal = mealList.first(where: { $0.name == order.mealName }){
                let quantity = Decimal(mealQuantity)
                return result + meal.price * quantity
            }
            
            // Handle the case when any of the optionals is nil
            result *= 1.15
            return result
        }
        
        // Apply 15% tax to the subtotal
        let tax = subtotal * Decimal(0.15)
        let totalWithTax = subtotal + tax
            
        let formattedTotal = NSDecimalNumber(decimal: totalWithTax).rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)).stringValue
        
        return formattedTotal
    }
    
    init(){
        loadExistingMealsFromDatabase()
        
        mealQuantities = [
            "0": 0,
            "1": 0,
            "2": 0,
            "3": 0,
            "4": 0,
            "5": 0
        ]
    }
    
    //initialize meals in database
    func loadExistingMealsFromDatabase(){
        self.restoRepo.$mealList
            .assign(to: \.mealList, on: self)
            .store(in: &cancellables)
        
        for meal in self.mealList {
            //print("Meal: \(meal.name); \(meal.price)")
        }
    }
    
    //for existing user
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        restoRepo.getCustomer(byUsername: username, password: password) { customer in
            if let unwrappedCustomer = customer {
                completion(true)
                self.name = "\(unwrappedCustomer.fName) \(unwrappedCustomer.lName)"
                print(self.name)
            } else {
                // Login failed
                completion(false)
            }
        }
    }


    //for new user
    func signUp(firstName: String, lastName: String, username: String, password: String) {
            // Check if any fields are empty
            guard !firstName.isEmpty, !lastName.isEmpty, !username.isEmpty, !password.isEmpty else {
                print("All fields must be filled out.")
                return
            }

            // Create a new customer object
        let newCustomer = Customer(fName: firstName, lName: lastName, username: username, password: password)

            // Call the repository function to add the customer
        restoRepo.addCustomer(newCustomer)
        }
    
    //passes the meals that were selected in the Checkout page
    func sendMealsToCheckout() {
        // Identify meals with quantities greater than 0
        let selectedMeals = self.mealList.filter { meal in
            if let mealID = meal.id{
                return mealQuantities[mealID, default: 0] > 0
            }
            return false
        }

        // Create a delivery with default values
        let newDelivery = Delivery(address: "", deliveryTime: "", totalCost: 0.0)

        // Add the delivery to Firestore and get the newly added deliveryId
        if let deliveryId = restoRepo.addDelivery(newDelivery) {
            // Successfully added delivery, and deliveryId contains the document ID
//            print("Delivery added with ID: \(deliveryId)")
            
            self.newDelivery.id=deliveryId
            
            for meal in selectedMeals {
                if let mealID = meal.id {
                    let quantity = mealQuantities[mealID, default: 0]
                    let order = Order(id: mealID, mealName: meal.name, quantity: String(quantity), deliveryId: deliveryId)
                    // Add the order to Firestore
                    restoRepo.addOrder(order)
                    self.orderList.append(order)
                } else {
                    // Handle the case when meal.id is nil
                    print("Error: meal.id is nil")
                }
            }
//            print("Order list: \(orderList)")
        }
    }
    
    //passes the order information to the ConfirmationMenu to display it back to user
    func confirmOrderClicked(deliveryAddress: String){
        // Generate a random delivery time between 10 and 40 minutes
        let deliveryTime = "\(Int.random(in: 10...40)) minutes"

        // Update the newly created delivery information
        self.newDelivery.address=deliveryAddress
        self.newDelivery.deliveryTime=deliveryTime
        if let totalCostDecimal = Decimal(string: totalCost) {
            self.newDelivery.totalCost = totalCostDecimal
        } else {
            // Handle the case where the conversion fails
            print("Error: Unable to convert totalCost to Decimal")
        }
        
        // Call the repository method to update the delivery
        restoRepo.updateDelivery(self.newDelivery)
    }
    
    //resets the meal quantities, order details, and meal details
    func clear(){
        self.mealQuantities = [
            "0": 0,
            "1": 0,
            "2": 0,
            "3": 0,
            "4": 0,
            "5": 0
        ]
        self.newDelivery = Delivery(address: "", deliveryTime: "", totalCost:0.0)
        self.orderList=[]
    }
    
    //when customer logs out, reset the name too
    func logout(){
        clear()
        self.name=""
    }
}
