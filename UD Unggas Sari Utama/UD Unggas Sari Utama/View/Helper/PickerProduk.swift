//
//  PickerProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct PickerProduk: View {
    
    @ObservedObject var viewModel : ProdukFetcher
    
    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Pilih", selection: $viewModel.selectedProduk) {
                ForEach(viewModel.produk, id: \.id) { produk in
                    Text(produk.nama_produk)
                }
            }
            .pickerStyle(.wheel)
        }
        .onAppear(){
            self.viewModel.fetchData()
        }
    }
}
