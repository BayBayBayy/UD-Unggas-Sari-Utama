//
//  DetailPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 29/03/23.
//

import SwiftUI

struct DetailPenjualanView: View {
    let penjualan: PenjualanResponseModel
    let dataDetailPenjualan: [DetailPenjualanModel]
    let dataProduk: ProdukFetcher
    @Binding var close: Bool
    

    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                VStack{
                    Text("Daftar Belanja")
                        .bold()
                        .font(.system(size: 24))
                        .padding(.top)
                    HStack{
                        Text("No")
                            .bold()
                            .font(.system(size: 16))
                        Text("Nama")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/5)
                        Text("Jumlah")
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                        Text("Harga")
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                        Text("Total")
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/12)
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/6)
                
                ScrollView(){
                    ForEach(dataDetailPenjualan, id: \.id) { index in
                        let produk = dataProduk.getProdukById(id: index.produk_id)
                        
                        HStack{
                            Text(index.produk_id)
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/10)
                            Text(produk!.nama_produk)
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/5)
                            Text("\(index.jumlah)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/5)
                            Text("\(index.harga)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/6)
                            Text("\(index.subTotal)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/5)
                        }.frame(width: geometry.size.width/1.1, height: geometry.size.height/8)
                    }
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2)
                
                VStack{
                    RoundedRectangle(cornerRadius: 0.1)
                        .fill(.black)
                        .frame(width: geometry.size.width/1, height: 2)
                    HStack{
                        Text("Harga Total")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        
                        Text("\(penjualan.total_harga)")
                            .bold()
                            .font(.system(size: 20))
                        
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/10)
                    Spacer()
                        .frame(width: geometry.size.width/1.1, height: geometry.size.height/18)
                    
                    Button{
                        close = false
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("GrayMiddleColor"))
                                . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                .cornerRadius(8)
                                .border(Color.black, width: 2)
                            Text("OK")
                                .bold()
                                .font(.title)
                        }
                        .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                    }
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .background(Color("GrayBackgroundColor"))
        }.edgesIgnoringSafeArea(.all)
        
    }
}

