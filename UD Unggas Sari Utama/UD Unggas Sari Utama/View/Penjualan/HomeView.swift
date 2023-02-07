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
                            .background(.yellow)
                        HStack{
                            CardProdukView()
                                .frame(width: geometry.size.width/1.5, height: geometry.size.height/1.75)
                            Spacer()
                                .frame(width: 10)
                            Spacer()
                                .frame(width: geometry.size.width/3.5, height: geometry.size.height/1.75)
                                .background(.green)
                        }.frame(width: geometry.size.width/1, height: geometry.size.height/1.75)
                        Spacer()
                            .frame(width: 10, height: geometry.size.height/4)
                            .background(.red)
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    .background(Color("GrayBackgroundColor"))
                    .navigationTitle("UD. Amerta Yoga")
                }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
            }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
        } else{
            // not allowed
        }
    }
}
