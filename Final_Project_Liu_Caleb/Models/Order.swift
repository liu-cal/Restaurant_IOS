//
//  Order.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-16.
//

import FirebaseFirestoreSwift

struct Order: Identifiable, Codable{
    @DocumentID var id: String?
    var mealName: String=""
    var quantity: String=""
    var deliveryId: Int=0
    
    init(){
        
    }
    
    init(mealName: String, quantity: String, deliveryId: Int){
        self.mealName=mealName
        self.quantity=quantity
        self.deliveryId=deliveryId
    }
}
