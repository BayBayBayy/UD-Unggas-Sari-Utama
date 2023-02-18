//
//  DataProdukView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 16/02/23.
//

import SwiftUI

struct DataProdukView: View{
    @ObservedObject var viewModel = ProdukFetcher()
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        var body: some View {
//            List(viewModel.produk, id: \.id) { product in
//                HStack {
//                    Text(product.id)
//                    Text(product.nama_produk)
//                    Text(product.satuan)
//                    Text(product.produk_kategori)
//                    Text(product.image)
//                    Text("\(product.harga)")
//                    Text("\(product.jumlah_produk)")
//                    Text("\(product.tanggal_masuk_produk)")
//                }
//            }
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.produk) { product in
                        VStack {
                            Text(product.id)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(product.nama_produk)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(product.satuan)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(product.produk_kategori)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(product.image)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(product.harga)")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(product.jumlah_produk)")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(product.tanggal_masuk_produk)")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
}

