//
//  Final_Project_Liu_CalebApp.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-16.
//

import SwiftUI
import Firebase

@main
struct Final_Project_Liu_CalebApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
