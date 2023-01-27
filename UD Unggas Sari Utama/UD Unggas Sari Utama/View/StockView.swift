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
                        HStack{
                            Spacer()
                                .frame(width: geometry.size.width/2.5, height: geometry.size.height/1)
                                .background(.green)
                            HStack{
                                NavigationLink {
                                    stokOpname()
                                } label: {
                                    VStack {
                                        Text("Laporan Stok")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16))
                                            .bold()
                                    }.frame(width: geometry.size.width/8, height: geometry.size.height/16)
                                    .background(.gray)
                                    .cornerRadius(20)
                                }
                                NavigationLink {
                                    stokOpname()
                                } label: {
                                    VStack {
                                        Text("Stok Opname")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16))
                                            .bold()
                                    }.frame(width: geometry.size.width/8, height: geometry.size.height/16)
                                        .background(.gray)
                                    .cornerRadius(20)
                                }
                                NavigationLink {
                                    stokOpname()
                                } label: {
                                    VStack {
                                        Text("Input Barang Baru")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16))
                                            .bold()
                                    }.frame(width: geometry.size.width/8, height: geometry.size.height/16)
                                    .background(.gray)
                                    .cornerRadius(20)
                                }
                                NavigationLink {
                                    stokOpname()
                                } label: {
                                    VStack {
                                        Text("Konversi Stok")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16))
                                            .bold()
                                    }.frame(width: geometry.size.width/8, height: geometry.size.height/16)
                                    .background(.gray)
                                    .cornerRadius(20)
                                }

                            }.frame(width: geometry.size.width/2, height: geometry.size.height/1)
                        }.frame(width: geometry.size.width/1, height: geometry.size.height/10)
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.3)
                            .background(.red)
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

struct stokOpname: View{
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                Text("blank")
            }
        }
    }
}
