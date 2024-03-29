//
//  EditProdukPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/03/23.
//

import SwiftUI

struct EditProdukPopupView: View {
    let vmEditProduk = ProdukManager()
    let produk: ProdukResponseModel
    @ObservedObject var viewModel = ProdukFetcher()
    @State var id : String
    @State var namaProduk : String
    @State var satuanProduk : String
    @State var kategoriProduk : String
    @State var hargaProduk :Int
    @State var ecer: Bool
    @State var status: Bool
    @State var tanggal: Date
    @Binding var check3: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.2, height: geometry.size.height/1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: 7) {
                    
                    title
                        . frame( height: geometry.size.height/8)
                    nama
                        . frame( height: geometry.size.height/12)
                    satuan
                        . frame( height: geometry.size.height/12)
                    
                    PickerKategori(selectedKategori: $kategoriProduk)
                        . frame( height: geometry.size.height/8)
                    
                    harga
                        . frame( height: geometry.size.height/12)
                    
                    DatePicker("Tanggal Produk", selection: $tanggal, displayedComponents: [.date])
                    
                    HStack{
                        CheckToggle(isOn: $ecer, title: "Eceran")
                            .padding(.bottom, 5)
                        
                        CheckToggle(isOn: $status, title: status ? "Masih Terjual" : "Tidak Terjual" )
                            .padding(.bottom, 5)
                    }
                    
                    HStack{
                        Button{
                            viewModel.fetchData()
                            vmEditProduk.editProduk(id: id, nama_produk: namaProduk, satuan: satuanProduk, produk_kategori: kategoriProduk, harga: "\(hargaProduk)", produk_ecer: ecer, status: status, tanggalMasukProduk: tanggal) { success, message in
                                if success {
                                    // Jika sukses, menampilkan pesan sukses dan menutup tampilan edit produk
                                    print(message)
                                   check3 = false
                                } else {
                                    // Jika gagal, menampilkan pesan error
                                    print(message)
                                }
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
                        
                        Button{
                            
                            check3 = false
                            
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
                    }
                    
                }.frame(width: geometry.size.width/1.5, height: geometry.size.height/1.5)
            }
            .onAppear(){
                if produk == viewModel.selectedProduk{
                    id = produk.id
                    namaProduk = produk.nama_produk
                    satuanProduk = produk.satuan
                    kategoriProduk = produk.produk_kategori
                    hargaProduk = produk.harga
                    ecer = produk.produk_ecer
                    status = produk.status_produk
                    tanggal = produk.tanggal_masuk_produk
                }
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            
        }.edgesIgnoringSafeArea(.all)
    }
}

extension EditProdukPopupView {
    var title : some View{
        Text("Edit Produk")
            .bold()
            .font(.system(size: 40))
    }
    var nama : some View{
        HStack{
            Text("Nama :")
            TextField("", text: $namaProduk)
        }
        .textFieldStyle(.roundedBorder)
    }
    var satuan : some View{
        HStack{
            Text("Satuan :")
            TextField("", text: $satuanProduk)
            
        }
        .textFieldStyle(.roundedBorder)
    }
    var kategori : some View{
        HStack{
            Text("Kategori :")
            TextField("", text: $kategoriProduk)
        }
        .textFieldStyle(.roundedBorder)
    }
    var harga : some View{
        HStack{
            Text("Harga :")
            TextField("", value: $hargaProduk,  formatter: NumberFormatter())
                .keyboardType(.numberPad)
        }
        .textFieldStyle(.roundedBorder)
    }    
}
