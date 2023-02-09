//
//  StockView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI
struct StockView: View {

//    @Binding var keyValueButton : Int
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        TabButtonActionStok()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/14, alignment: .bottom)
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.3)
                            .background(.red)
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    .background(Color("GrayBackgroundColor"))
                    .navigationTitle("Stok")
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

struct stokOpname: View{
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                Text("blank")
            }
        }
    }
}


