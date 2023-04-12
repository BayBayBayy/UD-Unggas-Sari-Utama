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
    @State var checkEdit: Bool = false
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    @ObservedObject var pemesananVM = FetchPemesanan()
    
    var jumlahProdukTersedia: [String: Int] {
        var stok: [String: Int] = [:]
        
        // Menghitung jumlah stok awal
        for produk in self.viewModel.produk {
            stok[produk.id] = produk.jumlah_produk
        }
        
        // Mengurangi stok sesuai jumlah pesanan yang belum terpenuhi pada tanggal pengambilan yang sama dengan tanggal saat ini
        let currentDate = Date()
        let filteredPemesanan = pemesananVM.dataPemesanan.filter { $0.tanggal_pengambilan == currentDate && $0.status == false }
        for pemesanan in filteredPemesanan {
            let filteredDetailPemesanan = pemesananVM.detailPemesanan.filter { $0.pemesanan_id == pemesanan.pemesanan_id }
            for detail in filteredDetailPemesanan {
                let produkId = detail.produk_id
                let jumlah = detail.jumlah_produk
                
                if let currentCount = stok[produkId] {
                    stok[produkId] = currentCount - jumlah
                }
            }
        }
        return stok
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
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
                        Text("Harga")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        Text("Jumlah")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        Text("Status")
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
                        ForEach(viewModel.produk, id:\.id) { product in
                            let jumlahTersedia = jumlahProdukTersedia[product.id] ?? product.jumlah_produk
                            HStack {
                                Text(product.id)
                                    .frame(maxWidth: .infinity)
                                Text(product.nama_produk)
                                    .frame(maxWidth: .infinity)
                                Text(product.satuan)
                                    .frame(maxWidth: .infinity)
                                Text(product.produk_kategori)
                                    .frame(maxWidth: .infinity)
                                Text(numberFormatter.string(from: NSNumber(value: product.harga)) ?? "")
                                    .frame(maxWidth: .infinity)
                                Text(String(jumlahTersedia))
                                    .frame(maxWidth: .infinity)
                                Text(product.status_produk ? "Masih Terjual" : "Tidak Dijual")
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
                            .background(product.status_produk ? Color.white : Color("RedPlain"))
                            .cornerRadius(8)
                        }
                    }
                }
                if checkEdit == true{
                    EditProdukPopupView(produk: viewModel.selectedProduk!, id: viewModel.selectedProduk!.id, namaProduk: viewModel.selectedProduk!.nama_produk, satuanProduk: viewModel.selectedProduk!.satuan, kategoriProduk: viewModel.selectedProduk!.produk_kategori, hargaProduk: viewModel.selectedProduk!.harga, ecer: viewModel.selectedProduk!.produk_ecer, status: viewModel.selectedProduk!.status_produk, tanggal: viewModel.selectedProduk!.tanggal_masuk_produk, check3: $checkEdit)
                        .frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    viewModel.fetchData()
                    pemesananVM.fetchData()
                    pemesananVM.fetchDataDetail()
                }
            }
            .onChange(of: checkEdit){ newValue in
                    if !newValue{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        viewModel.fetchData()
                    }
                }
            }
        }
    }
}

