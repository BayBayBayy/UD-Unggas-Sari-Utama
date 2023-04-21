//
//  LaporanStokView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct LaporanStokView: View {
    @ObservedObject var dataLaporan = LaporanStokFetcher()
    let dateFormatter = DateFormatter()
    @State var checkEdit: Bool = false
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack {
                    Text("ID Produk")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text("Nama")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text("Total Stok")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text("Stok Terjual")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text("Stok Selisih")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text("Stok Sisa")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    Text("Tanggal Barang Masuk")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                
                ScrollView {
                    ForEach(dataLaporan.produk, id:\.produk_id) { product in
                        HStack {
                            Text(product.produk_id)
                                .frame(maxWidth: .infinity)
                            Text(product.nama_produk)
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%1g", product.total_stok))
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%1g", product.stok_terjual))
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%1g", product.stok_selisih))
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%1g", product.stok_sisa))
                                .frame(maxWidth: .infinity)
                            Text(dateFormatter.string(from: product.tanggal_barang_masuk))
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(8)
                    }
                }
            }
            .background(Color("GrayBackgroundColor"))
            .navigationTitle("Laporan Stok")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    dataLaporan.fetchData()
                    
                }
            }
        }

    }
}

