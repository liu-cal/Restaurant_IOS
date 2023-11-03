//
//  LandingPage.swift
//  Final_Project_Liu_Caleb
//
//  Created by macuser on 2023-10-18.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("restaurant") // Replace with your restaurant background image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Liu's Restaurant")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    NavigationLink(destination: OrderMenu()) {
                        Text("Order Now")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
            
        }.navigationBarHidden(true)
    }
}



struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
