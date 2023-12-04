//
//  Delivery.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-16.
//

import FirebaseFirestoreSwift
import Foundation

struct Delivery: Identifiable, Codable{
    @DocumentID var id: String?
    var address: String = ""
    var deliveryTime: String=""
    var totalCost: Decimal=0.0
    
    init(){
        
    }
    
    init(address: String, deliveryTime: String, totalCost: Decimal){
        self.address=address
        self.deliveryTime=deliveryTime
        self.totalCost=totalCost
    }
}
