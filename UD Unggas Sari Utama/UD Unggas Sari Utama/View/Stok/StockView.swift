//
//  StockView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI
struct StockView: View {
    @State var checkStokOpname : Bool = false
//    @Binding var keyValueButton : Int
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        TabButtonActionStok(check: $checkStokOpname)
                            .frame(width: geometry.size.width/1, height: geometry.size.height/14, alignment: .bottom)
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.3)
                            .background(.red)
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    .background(Color("GrayBackgroundColor"))
                    .navigationTitle("Stok")
//                    .overlay(alignment: .bottom) {
//                        GeometryReader{ geometry in
//                            if checkStokOpname == true & keyValueButton = 1  {
//                                    StokOpnamePopupView(checkPopup: $checkStokOpname)
//                                    .frame(width: geometry.size.width/1.5, height:  geometry.size.height/1.5, alignment: .center)
//                                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.55)
//                            }
//
//                        }.edgesIgnoringSafeArea(.all)
//                    }
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
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


