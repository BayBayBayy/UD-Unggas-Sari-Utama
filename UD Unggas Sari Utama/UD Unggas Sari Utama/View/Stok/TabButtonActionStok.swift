//
//  TabButtonActionStok.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct TabButtonActionStok: View {
    @State var check : Bool = false

    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                    .frame(width: geometry.size.width/2.5, height: geometry.size.height/1)
                HStack{
                    
                    NavigationLink {
                        LaporanStokView()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                            VStack {
                                Text("Laporan")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        self.check.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                               
                            VStack {
                                Text("Stok Opname")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        self.check.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                            VStack {
                                Text("Input Barang Baru")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        .cornerRadius(8)
                    }
                    
                    Button {
                        self.check.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                            VStack {
                                Text("Konversi Stok")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        .cornerRadius(8)
                    }
                    
                }
                .frame(width: geometry.size.width/2, height: geometry.size.height/1)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/0.65)
            
        }.edgesIgnoringSafeArea(.all)
    }
}
