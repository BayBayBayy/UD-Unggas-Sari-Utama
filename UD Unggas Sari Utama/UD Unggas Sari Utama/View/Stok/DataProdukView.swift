//
//  DataProdukView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 16/02/23.
//

import SwiftUI

struct DataProdukView: View{
    @EnvironmentObject var viewModel: produkViewModel
    let data: ProdukResponseModel
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                Table(viewModel.items, id: \.idProduk) {
                    TableColumn("No Produk", value: \.idProduk)
                    TableColumn("nama", value: \.namaProduk)
                    TableColumn("", value: \.satuan)
                    TableColumn("Detail", value: \.produkKategori)
                    TableColumn("Detail", value: \.imageProduk)
                    TableColumn("Detail", value: \.jumlahProduk)
                    TableColumn("Detail", value: \.harga)
                    TableColumn("Detail", value: \.tanggalProduk)
                } .frame(width: geometry.size.width/1, height: geometry.size.height/1.5)
                Spacer()
                    .frame(width: geometry.size.width/1, height: geometry.size.height/8)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

