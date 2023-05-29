//
//  KonversiPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct KonversiPopupView: View {
    @State var jumlahSebelum : String = ""
    @State var jumlahSetelah : String = ""
    @Binding var check2: Bool
    @State var produkAsal: String = ""
    @State var produkJadi: String = ""
    let vmProduk = ProdukManager()
    var viewModelDataProduk: ProdukFetcher
    @State private var showingAlert = false
    @State private var showingAlertJumlah = false
    @State private var showingAlertJumlahNol = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1, height: geometry.size.height/0.9)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    
                    title
                        . frame( height: geometry.size.height/6)
                    HStack{
                        Text("Ubah dari")
                            .bold()
                            .font(.system(size: 28))
                        Spacer()
                    }.frame( height: geometry.size.height/10)
                    
                    PickerProdukEcer( selectedEcer: $produkAsal)
                        . frame( height: geometry.size.height/6)
                    fieldJumlahSebelum
                        . frame( height: geometry.size.height/8)
                    HStack{
                        Text("Menjadi")
                            .bold()
                            .font(.system(size: 28))
                        Spacer()
                    }.frame( height: geometry.size.height/10)
                    PickerProdukEcer( selectedEcer: $produkJadi)
                        . frame( height: geometry.size.height/6)
                    fieldJumlahSetelah
                        . frame( height: geometry.size.height/8)
                    HStack{
                        Button{
                            check2 = false
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
                            . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                        Button{
                            if jumlahSebelum != "" && jumlahSetelah != "" && produkAsal != "" && produkJadi != "" {
                                if let jumlah = getJumlahProduk(of: produkAsal),
                                   let jumlahnya = Float(jumlahSebelum),
                                   let jumlahJadi = Float(jumlahSetelah) {
                                    if jumlahnya <= jumlah && jumlahnya != 0 && jumlahJadi != 0 {
                                        vmProduk.konversiProduk(id_asal: produkAsal, id_jadi: produkJadi, jumlah_asal: jumlahSebelum, jumlah_jadi: jumlahSetelah) { success, message in
                                            if success {
                                                // Jika sukses, menampilkan pesan sukses dan menutup tampilan edit produk
                                                print(message)
                                                check2 = false
                                            } else {
                                                // Jika gagal, menampilkan pesan error
                                                print(message)
                                            }
                                        }
                                    } else {
                                        showingAlertJumlah = true
                                    }
                                }
                            } else {
                                showingAlert = true
                            }
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("OK")
                                    .bold()
                                    .font(.title)
                            }
                            . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                    }
                }
                .frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Peringatan"), message: Text("Informasi produk tidak boleh kosong!"), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showingAlertJumlah) {
                Alert(title: Text("Peringatan"), message: Text("Jumlah Tidak sesuai!"), dismissButton: .default(Text("OK")))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func getJumlahProduk(of namaProduk: String) -> Float? {
        if let produk = viewModelDataProduk.produk.first(where: { $0.nama_produk == namaProduk }) {
            return produk.jumlah_produk
        } else {
            return nil
        }
    }
}

extension KonversiPopupView {
    var title : some View{
        Text("Konversi Stok")
            .bold()
            .font(.system(size: 40))
    }
    var fieldJumlahSebelum : some View{
        HStack{
            Text("Jumlah :")
            TextField("Masukan jumlah asal produk", text: $jumlahSebelum)
        }
        .textFieldStyle(.roundedBorder)
    }
    var fieldJumlahSetelah : some View{
        HStack{
            Text("Jumlah :")
            TextField("Masukan jumlah jadi produk", text: $jumlahSetelah)
        }
        .textFieldStyle(.roundedBorder)
    }
    
}
