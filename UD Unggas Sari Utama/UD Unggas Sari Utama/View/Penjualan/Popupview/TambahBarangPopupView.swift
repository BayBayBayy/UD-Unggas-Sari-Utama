//
//  TambahBarangPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 11/02/23.
//

import SwiftUI

struct TambahBarangPopupView: View {
    @State private var jumlahInput: Float = 0
    @State private var valueString: String = ""
    @EnvironmentObject var viewModel: PenjualanViewModel
    let produk: ProdukResponseModel
    @State private var showingAlert = false
    @State private var isAlertPesanan = false
    @State private var alertMessage = ""
    var vmProduk: ProdukFetcher
    @ObservedObject var pemesananVM = FetchPemesanan()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = Locale.current.decimalSeparator
        return formatter
    }()
    
    func validateJumlah() {
        if jumlahInput > 0 {
            guard let jumlahTersedia = jumlahProdukTersedia(id: produk.id) else {
                print("Error: failed to get jumlah produk tersedia")
                return
            }
            if Int(jumlahInput) > Int(produk.jumlah_produk) || Int(jumlahInput) > jumlahTersedia {
                alertMessage = "Jumlah melebihi stok yang tersedia, periksa jumlah produk dan pesanan hari ini!"
                isAlertPesanan = true
            } else {
                // Tambahkan ke list belanja di view model
                viewModel.tambahDetailPenjualan(penjualanId: "", produkId: produk.id, jumlah: Float(jumlahInput))
                jumlahInput = 0 // Reset jumlah ke 0
                print("Data berhasil ditambahkan!")
                self.close.toggle()
                self.cancelList = true
            }
        } else {
            // Tampilkan notifikasi bahwa jumlahInput kosong
            showingAlert = true
            print("Jumlah input tidak boleh kosong!")
        }
    }

    func jumlahProdukTersedia(id: String) -> Int? {
        var jumlahTerjual = 0
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        let date = dateFormatter.date(from: dateString)
        
        // Menghitung total produk yang terjual pada tanggal yang sama
        let filteredPemesanan = pemesananVM.dataPemesanan.filter { $0.tanggal_pengambilan == date && $0.status == false }
        print("Jumlah data pemesanan: \(pemesananVM.dataPemesanan.count)")
        print("ini datanya \(filteredPemesanan)")
        for pemesanan in filteredPemesanan {
            let filteredDetailPemesanan = pemesananVM.detailPemesanan.filter { $0.pemesanan_id == pemesanan.pemesanan_id }
            for detailPemesanan in filteredDetailPemesanan {
                if detailPemesanan.produk_id == id {
                    jumlahTerjual += Int(detailPemesanan.jumlah_produk)
                }
            }
        }
        print("ini jumlah dipesan \(jumlahTerjual)")
        // Menghitung total produk yang tersedia
        if let produk = vmProduk.getProdukById(id: id) {
            let totalProduk = produk.jumlah_produk
            print("ini total produk\(totalProduk)")
            let tersedia = totalProduk - Float(jumlahTerjual)
            print("ini jumlah tersedia\(tersedia)")
            return tersedia > 0 ? Int(tersedia) : 0
        }
        
        return 0
    }

    
    func onTambahKePesananTapped() {
        if jumlahInput != Float("") {
            if jumlahInput > 0 {
                // Tambahkan ke list belanja di view model
                viewModel.tambahDetailPenjualan(penjualanId: "", produkId: produk.id, jumlah: Float(jumlahInput))
                jumlahInput = 0 // Reset jumlah ke 0
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
            TextField("0", text: $valueString)
                .foregroundColor(.black)
                .keyboardType(.decimalPad)
                        .onChange(of: valueString) { newValue in
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            formatter.minimumFractionDigits = 1
                            formatter.maximumFractionDigits = 1
                            formatter.roundingMode = .halfUp
                            formatter.decimalSeparator = ","

                            if let number = formatter.number(from: newValue) {
                                jumlahInput = number.floatValue
                            }


                        }
            
        }
        .textFieldStyle(.roundedBorder)
    }
}
