//
//  HomeView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var visibility: Visibility
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    .navigationTitle("UD. Amerta Yoga")
                    
            
                }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
            }
            .onAppear{
                visibility = .visible
              
            }
            .onDisappear{
                visibility = .visible
            }
            .toolbar(visibility, for: .tabBar)
            
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()

            
        } else{
        // not allowed
        }
    }
}
