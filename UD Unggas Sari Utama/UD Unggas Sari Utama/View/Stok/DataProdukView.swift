////
////  DataProdukView.swift
////  UD Unggas Sari Utama
////
////  Created by I Wayan Adnyana on 16/02/23.
////
//
//import SwiftUI
//
//struct DataProdukView: View{
//    @EnvironmentObject var viewModel: produkViewModel
//    var body: some View{
//        GeometryReader{ geometry in
//            VStack{
//                Table(viewModel.items, id: \.idProduk) {
//                    TableColumn("No Produk", value: \.idProduk)
//                    TableColumn("nama", value: \.namaProduk)
//                    TableColumn("satuan", value: \.satuan)
//                    TableColumn("kategori", value: \.produkKategori)
//                    TableColumn("image", value: \.imageProduk)
//                    TableColumn("jumlah", value: \.jumlahProduk)
//                    TableColumn("harga", value: \.harga)
//                    TableColumn("tanggal", value: \.tanggalProduk)
//                } .frame(width: geometry.size.width/1, height: geometry.size.height/1.5)
//                Spacer()
//                    .frame(width: geometry.size.width/1, height: geometry.size.height/8)
//            }.task({
//                await viewModel.fetchData()
//            })
//            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
//        }.edgesIgnoringSafeArea(.all)
//    }
//}
//
