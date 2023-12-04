//
//  Meal.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-16.
//

import FirebaseFirestoreSwift
import Foundation

struct Meal: Identifiable, Codable{
    @DocumentID var id: String?
    var name: String = ""
    var price: Decimal = 0.0
    
    init(){}
    init(name: String, price: Decimal){
        self.name=name
        self.price=price
    }
}
