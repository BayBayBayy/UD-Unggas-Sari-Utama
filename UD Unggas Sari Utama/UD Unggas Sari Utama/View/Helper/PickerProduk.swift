//
//  PickerProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct PickerProduk: View {
    
    @ObservedObject var viewModel : ProdukFetcher
    @Binding var selectedProduk: String 
    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Pilih", selection: $selectedProduk) {
                ForEach(viewModel.produk, id: \.id) { produk in
                    Text(produk.nama_produk)
                        .tag(produk)
                }
            }
            .pickerStyle(.wheel)
        }
        .onAppear(){
            self.viewModel.fetchData()
        }
    }
}

struct PickerProdukEcer: View {
    
    @ObservedObject var viewModel : ProdukFetcher
    @Binding var selectedEcer: String
    
    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Pilih", selection: $selectedEcer) {
                ForEach(viewModel.produkEcer, id: \.id) { produk in
                    Text(produk.nama_produk)
                        .tag(produk)
                }
            }
            .pickerStyle(.wheel)
        }
        .onAppear(){
            self.viewModel.fetchData()
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
                ForEach(kategori, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
