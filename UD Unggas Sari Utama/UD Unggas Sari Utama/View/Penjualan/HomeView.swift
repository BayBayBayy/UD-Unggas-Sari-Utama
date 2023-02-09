//
//  HomeView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct HomeView: View {
    @State var favoriteCards: [produkDummy] = produkDummy.sampleData
    
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        Spacer()
                            .frame(width: geometry.size.width/14, height: geometry.size.height/14)
                        
                        HStack{
                            CardProdukView()
                                .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.75)
                            Spacer()
                                .frame(width: 10)
                            ShoppingChartView()
                                .frame(width: geometry.size.width/2.75, height: geometry.size.height/1.75)
                                .background(Color("GrayContentColor"))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                                    .shadow(radius: 1))
                        }.frame(width: geometry.size.width/1, height: geometry.size.height/1.75)
                        
                        Spacer()
                            .frame(height: geometry.size.height/16)
                        
                        ButtonView()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/6)
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    .background(Color("GrayBackgroundColor"))
                    .navigationTitle("UD. Amerta Yoga")
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                .accentColor(Color("OrangeColorSet"))
            }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
        } else{
            // not allowed
        }
    }
}
