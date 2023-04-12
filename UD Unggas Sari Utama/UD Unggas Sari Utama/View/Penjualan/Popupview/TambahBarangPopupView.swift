//
//  TambahBarangPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 11/02/23.
//

import SwiftUI

struct TambahBarangPopupView: View {
    @State private var jumlahInput = ""
    @EnvironmentObject var viewModel: PenjualanViewModel
    let produk: ProdukResponseModel
    @State private var showingAlert = false
    @State private var isAlertShown = false
    @State private var isAlertPesanan = false
    @State private var alertMessage = ""
    var vmProduk: ProdukFetcher
    @ObservedObject var pemesananVM = FetchPemesanan()
    
    var jumlahProdukTersedia: [String: Int] {
        var stok: [String: Int] = [:]
        
        // Menghitung jumlah stok awal
        for produk in self.vmProduk.produk {
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
    
    func validateJumlah() {
        guard let selectedProduk = vmProduk.selectedProduk else { return }
        if let jumlah = Int(jumlahInput), jumlah > selectedProduk.jumlah_produk {
            alertMessage = "Jumlah melebihi stok yang tersedia"
            isAlertShown = true
        } else {
            
            if jumlahInput != "" {
                if let jumlahInt = Int(jumlahInput), jumlahInt > 0 {
                    // Tambahkan ke list belanja di view model
                    viewModel.tambahDetailPenjualan(penjualanId: "", produkId: produk.id, jumlah: jumlahInt)
                    jumlahInput = "0" // Reset jumlah ke 0
                    print("Data berhasil ditambahkan!")
                    self.close.toggle()
                }
                self.cancelList = true
            } else {
                // Tampilkan notifikasi bahwa jumlahInput kosong
                showingAlert = true
                print("Jumlah input tidak boleh kosong!")
            }
            
        }
    }
    
    func onTambahKePesananTapped() {
        if jumlahInput != "" {
            if let jumlahInt = Int(jumlahInput), jumlahInt > 0 {
                // Tambahkan ke list belanja di view model
                viewModel.tambahDetailPenjualan(penjualanId: "", produkId: produk.id, jumlah: jumlahInt)
                jumlahInput = "0" // Reset jumlah ke 0
                print("Data berhasil ditambahkan!")
            }
            self.close.toggle()
            self.cancelList = true
        } else {
            // Tampilkan notifikasi bahwa jumlahInput kosong
            showingAlert = true
            print("Jumlah input tidak boleh kosong!")
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    @Binding var close: Bool
    @Binding var cancelList: Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.1, height: geometry.size.height/1.3)
                    .border(Color(.black))
                
                VStack (alignment: .center, spacing: .zero) {
                    title
                        .frame( height: geometry.size.height/6)
                    HStack{
                        Text("Nama :")
                        Spacer()
                            .frame(width: geometry.size.width/18)
                        Text(produk.nama_produk)
                            .bold()
                        Spacer()
                    }.frame( height: geometry.size.height/7)
                    
                    HStack{
                        Text("Harga :")
                        Spacer()
                            .frame(width: geometry.size.width/18)
                        Text(numberFormatter.string(from: NSNumber(value: produk.harga)) ?? "")
                            .bold()
                        Spacer()
                    }.frame( height: geometry.size.height/7)
                    
                    HStack{
                        jumlah
                            .frame(width: geometry.size.width/1.6)
                        Text(produk.satuan)
                            .bold()
                            .frame(width: geometry.size.width/6)
                        Spacer()
                    }.frame( height: geometry.size.height/7)
                    
                    HStack{
                        Button{
                            self.close = false
                            self.cancelList = false
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("Batal")
                                    .bold()
                                    .font(.title)
                            }
                            .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                        
                        Button{
                            validateJumlah()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("OK")
                                    .bold()
                                    .font(.title)
                            }
                            .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                    }
                }.frame( width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Peringatan"), message: Text("Jumlah tidak boleh kosong!"), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $isAlertShown) {
                Alert(
                    title: Text("Peringatan"),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("Tambah Ke Pesanan"), action: onTambahKePesananTapped),
                    secondaryButton: .cancel(Text("Batal"), action: { self.close = false})
                )
            }
            .alert(isPresented: $isAlertPesanan) {
                Alert(
                    title: Text("Peringatan"),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("Tambah Ke Pesanan"), action: onTambahKePesananTapped),
                    secondaryButton: .cancel(Text("Batal"), action: { self.close = false})
                )
            }
            .onReceive(viewModel.$reloadList) { _ in
                print("List belanja diperbarui")
            }
            .frame( width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

extension TambahBarangPopupView{
    var title : some View{
        Text("Tambahkan ke Daftar Belanja")
            .bold()
            .font(.system(size: 36))
    }
    var jumlah : some View{
        HStack{
            Text("jumlah :")
            TextField("0", text: $jumlahInput)
                .foregroundColor(.black)
                .keyboardType(.numberPad)
            
        }
        .textFieldStyle(.roundedBorder)
    }
}
