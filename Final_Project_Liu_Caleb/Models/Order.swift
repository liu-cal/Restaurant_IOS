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
    var deliveryId: String=""
    
    init(){
        
    }
    
    init(id: String, mealName: String, quantity: String, deliveryId: String){
        self.id=id
        self.mealName=mealName
        self.quantity=quantity
        self.deliveryId=deliveryId
    }
}
