//
//  TabButtonActionStok.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct TabButtonActionStok: View {
    @Binding var check : Bool
    @Binding var valuePopup: Int
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                    .frame(width: geometry.size.width/2.9, height: geometry.size.height/1)
                HStack{
                    NavigationLink {
                        LaporanStokView()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/6, height: geometry.size.height/1.75)
                            VStack {
                                Text("Laporan")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/6, height: geometry.size.height/1.75)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        self.check.toggle()
                        valuePopup = 1
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/7, height: geometry.size.height/1.75)
                            VStack {
                                Text("Stok Opname")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/7, height: geometry.size.height/1.75)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        self.check.toggle()
                        valuePopup = 2
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/7, height: geometry.size.height/1.75)
                            VStack {
                                Text("Input Barang Baru")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/7, height: geometry.size.height/1.75)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        self.check.toggle()
                        valuePopup = 3
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/7, height: geometry.size.height/1.75)
                            VStack {
                                Text("Konversi Stok")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/7, height: geometry.size.height/1.75)
                        .cornerRadius(8)
                    }
                    
                }
                .frame(width: geometry.size.width/2, height: geometry.size.height/1)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/0.65)
            
        }.edgesIgnoringSafeArea(.all)
    }
}
