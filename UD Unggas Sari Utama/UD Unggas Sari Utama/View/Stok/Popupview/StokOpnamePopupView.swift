//
//  StokOpnamePopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 03/02/23.
//

import SwiftUI

struct StokOpnamePopupView: View {
    @State var jumlah : String = ""
    @State var keterangan : String = ""
    @State var produkSelect : String = ""
    @State var statusBertambah: Bool = false
    @State var statusBerkurang: Bool = false
    @State private var showingAlert = false
    @Binding var check1: Bool
    @ObservedObject var viewModel = ProdukFetcher()
    @ObservedObject var viewModelPenjualan = FethcerPenjualan()
    @ObservedObject var viewModelPemesanan = FetchPemesanan()
    let vmCreateProduk = ProdukManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.1, height: geometry.size.height/1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    title
                        . frame( height: geometry.size.height/8)
                    PickerProduk(viewModel: viewModel, selectedProduk: $produkSelect)
                        . frame( height: geometry.size.height/4)
                    choiceSituation
                        . frame( height: geometry.size.height/8)
                    fieldJumlah
                        . frame( height: geometry.size.height/8)
                    fieldKeterangan
                        . frame( height: geometry.size.height/8)
                    Spacer()
                    
                    HStack{
                        Button{
                            check1 = false
                        } label:{
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
                            if jumlah != "" && keterangan != "" {
                                vmCreateProduk.stokOpname(id_produk: produkSelect, keterangan: keterangan, produkBertambah: statusBertambah, produkBerkurang: statusBerkurang, jumlah: jumlah){ success, message in
                                    if success {
                                        // Jika sukses, menampilkan pesan sukses dan menutup tampilan edit produk
                                        print(message)
                                       check1 = false
                                    } else {
                                        // Jika gagal, menampilkan pesan error
                                        print(message)
                                    }
                                }
                            } else{
                                showingAlert = true
                            }
                        } label:{
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
                            . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                    }
                }.frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Peringatan"), message: Text("Informasi produk tidak boleh kosong!"), dismissButton: .default(Text("OK")))
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

 extension StokOpnamePopupView {
    var title : some View{
        Text("Stok Opname")
            .bold()
            .font(.system(size: 40))
    }
    var choiceSituation : some View{
        HStack{
            Text("Produk :")
            RadioButtonGroups(callback: { selectedId in
                // Lakukan sesuatu saat radio button dipilih
            }, selectedId: "",statusBertambah: $statusBertambah, statusBerkurang: $statusBerkurang)
        }
    }
     var fieldJumlah : some View{
         HStack{
             Text("Jumlah :")
             TextField("Masukan jumlah produk", text: $jumlah)
         }
         .textFieldStyle(.roundedBorder)
         .keyboardType(.numberPad)
    
     }
     var fieldKeterangan : some View{
         HStack{
             Text("Keterangan :")
             TextField("Masukan keterangan produk", text: $keterangan)
         }
         .textFieldStyle(.roundedBorder)
     }
}

func generateStokOpname() {
    
}
