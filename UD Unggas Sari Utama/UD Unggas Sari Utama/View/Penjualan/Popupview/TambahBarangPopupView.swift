//
//  TambahBarangPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 11/02/23.
//

import SwiftUI

struct TambahBarangPopupView: View {
    @State private var jumlahInput = "0"
    @EnvironmentObject var viewModel: PenjualanViewModel
    let produk: ProdukResponseModel
    
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
                    
                    Button{
                        if let jumlahInt = Int(jumlahInput), jumlahInt > 0 {
                            // Tambahkan ke list belanja di view model
                            viewModel.tambahDetailPenjualan(penjualanId: "", produkId: produk.id, jumlah: jumlahInt)
                            jumlahInput = "0" // Reset jumlah ke 0
                            print("Data berhasil ditambahkan!")
                            print("Data berhasil ditambahkan: produk ID \(produk.id), jumlah \(jumlahInt)")
                        }
                        self.close.toggle()
                        self.cancelList = true
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
                }.frame( width: geometry.size.width/1.2, height: geometry.size.height/1.2)
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
            TextField("", text: $jumlahInput)
                .keyboardType(.numberPad)
            
        }
        .textFieldStyle(.roundedBorder)
    }
}
