//
//  PickerProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct PickerProduk: View {
    
    @ObservedObject var viewModel = ProdukFetcher()
    @Binding var selectedProduk: String 
    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Pilih", selection: $selectedProduk) {
                Text("Pilih Produk")
                    .tag("")
                ForEach(viewModel.produk, id: \.id) { produk in
                    Text(produk.nama_produk)
                        .tag(produk.nama_produk)
                }
            }
            .pickerStyle(.wheel)
        }
        .onAppear(){
            self.viewModel.fetchData()
            self.selectedProduk = ""
        }
    }
}

struct PickerProdukEcer: View {
    @ObservedObject var viewModel = ProdukFetcher()
    @Binding var selectedEcer: String

    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Pilih", selection: $selectedEcer) {
                Text("Pilih Produk")
                    .tag("")
                ForEach(viewModel.produk, id: \.id) { produk in
                    if produk.produk_ecer == true{
                        Text(produk.nama_produk)
                            .tag(produk.nama_produk)
                    }
                }
            }
            .pickerStyle(.wheel)
        }
        .onAppear(){
            self.viewModel.fetchData()
            self.selectedEcer = "" // Set opsi default ketika tampilan muncul
        }
    }
}

struct PickerKategori: View {
    
    let kategori = ["Daging Unggas", "Bibit Unggas", "Pakan Hewan", "Obat Hewan", "Peralatan Unggas", "Service", "Lain-lain"]
    @Binding var selectedKategori: String
    
    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Pilih", selection: $selectedKategori) {
                Text("Pilih Kategori")
                    .tag("")
                ForEach(kategori, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
