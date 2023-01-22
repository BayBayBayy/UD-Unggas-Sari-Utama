//
//  StockView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI
struct StockView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        Text("Stok View")
                    }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .navigationTitle("Stok")
                    
                    
                }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
            }
            
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
            
            
        } else{
            // not allowed
        }
    }
}
