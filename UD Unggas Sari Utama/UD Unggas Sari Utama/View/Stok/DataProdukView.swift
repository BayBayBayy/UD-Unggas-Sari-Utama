//
//  DataProdukView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 16/02/23.
//

import SwiftUI

struct DataProdukView: View{
    @ObservedObject var viewModel = ProdukFetcher()
    let dateFormatter = DateFormatter()
    @Binding var checkEdit: Bool
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    var body: some View {
        VStack{
            HStack {
                Text("ID Produk")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Nama")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Satuan")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Kategori")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Image")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Price")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Jumlah")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Tanggal")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text("Opsi")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
            ScrollView {
                ForEach(viewModel.produk) { product in
                    HStack {
                        Text(product.id)
                            .frame(maxWidth: .infinity)
                        Text(product.nama_produk)
                            .frame(maxWidth: .infinity)
                        Text(product.satuan)
                            .frame(maxWidth: .infinity)
                        Text(product.produk_kategori)
                            .frame(maxWidth: .infinity)
                        Text(product.image)
                            .frame(maxWidth: .infinity)
                        Text(numberFormatter.string(from: NSNumber(value: product.harga)) ?? "")
                            .frame(maxWidth: .infinity)
                        Text(String(product.jumlah_produk))
                            .frame(maxWidth: .infinity)
                        Text(dateFormatter.string(from: product.tanggal_masuk_produk))
                            .frame(maxWidth: .infinity)
                        Button(action: {
                            self.checkEdit = true
                            self.viewModel.selectProduk(produk: product)
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("OrangeColorSet"))
                                    .frame(width: 80, height: 40)
                                Text("Edit")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }.frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
        }
        .onAppear {
            dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
            viewModel.fetchData()
        }
    }
}

