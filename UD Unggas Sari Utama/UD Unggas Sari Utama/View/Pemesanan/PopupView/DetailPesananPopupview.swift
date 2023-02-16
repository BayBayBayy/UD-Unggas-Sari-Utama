//
//  DetailPesananPopupview.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct DetailPesananPopupview: View {
    @State var namaPemesan1: String = ""
    @State var noHp1: String = ""
    @State var dpDibayar1: String = ""
    @State var selectedDate1 = Date()
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.2)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    
                    title
                        .frame( height: geometry.size.height/10)
                    Spacer()
                        .frame( height: geometry.size.height/12)
                    VStack{
                        HStack{
                            Text("No Pesanan :")
                            Spacer()
                                .frame(width: geometry.size.width/18)
                            Text("No pesanan")
                                .bold()
                            Spacer()
                        }.frame( height: geometry.size.height/24)
                        HStack{
                            Text("Nama :")
                            Spacer()
                                .frame(width: geometry.size.width/18)
                            Text("nama pembeli")
                                .bold()
                            Spacer()
                        }.frame( height: geometry.size.height/24)
                        HStack{
                            Text("No HP :")
                            Spacer()
                                .frame(width: geometry.size.width/18)
                            Text("No HP PEMbeli")
                                .bold()
                            Spacer()
                        }.frame( height: geometry.size.height/24)
                        HStack{
                            Text("Tanggal diambil :")
                            Spacer()
                                .frame(width: geometry.size.width/18)
                            Text("Tanggal diambil")
                                .bold()
                            Spacer()
                        }.frame( height: geometry.size.height/24)
                        HStack{
                            Text("Tanggal pemesanan :")
                            Spacer()
                                .frame(width: geometry.size.width/18)
                            Text("Tanggal pemesanan")
                                .bold()
                            Spacer()
                        }.frame( height: geometry.size.height/24)
                    }.frame( height: geometry.size.height/12)
                    
                    Spacer()
                        .frame( height: geometry.size.height/12)
    
                    VStack{
                        HStack{
                            Text("No")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/10)
                            Text("Nama")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/9)
                            Text("Jumlah")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/10)
                            Text("Harga")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/10)
                            Text("Total")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/10)
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/20)
                        
                        ScrollView{
                            HStack{
                                Spacer()
                                    .frame(width: geometry.size.width/20)
                                Text("1")
                                    .bold()
                                    .font(.system(size: 16))
                                    .frame(width: geometry.size.width/10)
                                Text("Ayam Broiler")
                                    .bold()
                                    .font(.system(size: 16))
                                    .frame(width: geometry.size.width/9)
                                Text("2")
                                    .bold()
                                    .font(.system(size: 16))
                                    .frame(width: geometry.size.width/10)
                                Text("12000")
                                    .bold()
                                    .font(.system(size: 16))
                                    .frame(width: geometry.size.width/10)
                                Text("24000")
                                    .bold()
                                    .font(.system(size: 16))
                                    .frame(width: geometry.size.width/10)
                                Spacer()
                                    .frame(width: geometry.size.width/28)
                            }.frame(width: geometry.size.width/2, height: geometry.size.height/16)
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/6)
  
                    }.frame(width: geometry.size.width/1.75, height: geometry.size.height/4)

                    VStack{
                        RoundedRectangle(cornerRadius: 0.1)
                            .fill(.black)
                            .frame(width: geometry.size.width/1.75, height: 2)
                        HStack{
                            Text("Harga Total")
                                .bold()
                                .font(.system(size: 18))
                            Spacer()
                            Text("24000")
                                .bold()
                                .font(.system(size: 18))
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/20)
                        
                        HStack{
                            Text("DP Dibayar")
                                .bold()
                                .font(.system(size: 18))
                            Spacer()
                            Text("12000")
                                .bold()
                                .font(.system(size: 18))
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/20)
                        
                        HStack{
                            Text("Sisa Pembayaran")
                                .bold()
                                .font(.system(size: 18))
                            Spacer()
                            Text("12000")
                                .bold()
                                .font(.system(size: 18))
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/20)
                    }.frame(width: geometry.size.width/2, height: geometry.size.height/14)
                    Spacer()
                        .frame(width: geometry.size.width/1.6, height: geometry.size.height/16)

                    Button(action: generatePesanan) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("GrayMiddleColor"))
                                . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                .cornerRadius(8)
                                .border(Color.black, width: 2)
                            Text("SELESAI")
                                .bold()
                                .font(.title2)
                        }
                        .frame( width: geometry.size.width/14, height: geometry.size.height/18)
                    }.frame( width: geometry.size.width/14, height: geometry.size.height/18)
                    
                    Spacer()
                        .frame(width: geometry.size.width/1.6, height: geometry.size.height/14)
                    
                }.frame( width: geometry.size.width/2, height: geometry.size.height/1.6)
                   
            }.frame( width: geometry.size.width/1, height: geometry.size.height/1)
            Spacer()
                .frame( width: geometry.size.width/1, height: geometry.size.height/14)
        }.edgesIgnoringSafeArea(.all)
        
    }
}

extension DetailPesananPopupview{
    var title : some View{
        Text("Pesanan")
            .bold()
            .font(.system(size: 40))
    }
    
    var tanggal : some View{
        HStack{
            Text("Tanggal Prngambilan :")
            DatePicker("", selection: $selectedDate1, displayedComponents: .date)
        }
        .textFieldStyle(.roundedBorder)
    }
}

struct buttonPopup: View{
    var body: some View{
        GeometryReader{ geometry in
            Button(action: generatePesanan) {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("GrayMiddleColor"))
                        . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        .cornerRadius(8)
                        .border(Color.black, width: 2)
                    Text("SELESAI")
                        .bold()
                        .font(.title2)
                }
                .frame( width: geometry.size.width/14, height: geometry.size.height/18)
            }.frame( width: geometry.size.width/14, height: geometry.size.height/18)
        }
    }
}
