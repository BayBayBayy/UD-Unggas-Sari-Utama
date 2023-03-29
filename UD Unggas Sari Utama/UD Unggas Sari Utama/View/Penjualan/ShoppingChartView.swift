//
//  ShoppingChartView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct ShoppingChartView: View {
    @Binding var showPesanan: Bool
    @Binding var checkList: Bool
    @EnvironmentObject var penjualanViewModel: PenjualanViewModel
    var viewModel: ProdukFetcher
    @State private var reloadList = UUID()
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
                    ForEach(penjualanViewModel.detailPenjualanList.indices, id: \.self) { index in
                        let detailPenjualan = penjualanViewModel.detailPenjualanList[index]
                        let produk = viewModel.getProdukById(id: detailPenjualan.produk_id)
                        
                        HStack{
                            Text("\(index + 1)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/10)
                            Text(produk!.nama_produk)
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/5)
                            Text("\(detailPenjualan.jumlah)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/5)
                            Text("\(detailPenjualan.harga)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(width: geometry.size.width/6)
                            Text("\(detailPenjualan.subHarga)")
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
                        Text("\(penjualanViewModel.totalHarga)")
                            .bold()
                            .font(.system(size: 20))
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/10)
                    Spacer()
                        .frame(width: geometry.size.width/1.1, height: geometry.size.height/18)
                    HStack{
                        Text("Pesanan")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Toggle("", isOn: $showPesanan)
                            .disabled(checkList ? false : true )
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/10)
                    
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
            }
            .onReceive(penjualanViewModel.$reloadList) { _ in
                reloadList = UUID()
                print("List belanja diperbarui")
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}
