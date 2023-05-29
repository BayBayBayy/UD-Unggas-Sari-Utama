//
//  NewProductPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 05/02/23.
//

import SwiftUI

struct NewProductPopupView: View {
    let vmCreateProduk = ProdukManager()
    @State var id : String = " "
    @State var namaProduk : String = ""
    @State var satuanProduk : String = ""
    @State var kategoriProduk : String = ""
    @State var hargaProduk : String = ""
    @State var jumlahProduk : String = ""
    @State var ecer: Bool = false
    @State var tanggal: Date = Date()
    @Binding var check3: Bool
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.2, height: geometry.size.height/1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    
                    title
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    nama
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    satuan
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    PickerKategori(selectedKategori: $kategoriProduk)
                        . frame( height: geometry.size.height/8)
                        .padding(.vertical, 10)
                    harga
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    jumlah
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    DatePicker("Tanggal Produk", selection: $tanggal, displayedComponents: [.date])
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    CheckToggle(isOn: $ecer, title: "Eceran")
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, 10)
                    
                    Spacer()
                    
                    HStack{
                        Button{
                            check3 = false
                        } label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("Batal")
                                    .bold()
                                    .font(.title)
                            }
                            . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                        
                        Button{
                            if namaProduk != "" && satuanProduk != "" && kategoriProduk != "" && hargaProduk != "" && jumlahProduk != ""{
                                vmCreateProduk.simpanProduk(id: id, nama_produk: namaProduk, satuan: satuanProduk, produk_kategori: kategoriProduk, harga: hargaProduk, jumlah_produk: jumlahProduk, produk_ecer: ecer, tanggal_masuk_produk: tanggal){ response in
                                    if response != nil {
                                        print("Data berhasil disimpan")
                                        check3.toggle()
                                    } else {
                                        print("Terjadi kesalahan saat menyimpan data")
                                    }
                                }
                            } else{
                                showingAlert = true
                            }
                            
                        } label:{
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("OK")
                                    .bold()
                                    .font(.title)
                            }
                            . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                    }.padding(.bottom, 10)
                    
                }.frame(width: geometry.size.width/1.5, height: geometry.size.height/1.3)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Peringatan"), message: Text("Informasi produk tidak boleh kosong!"), dismissButton: .default(Text("OK")))
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

extension NewProductPopupView {
    var title : some View{
        Text("Input Produk Baru")
            .bold()
            .font(.system(size: 40))
    }
    var nama : some View{
        HStack{
            Text("Nama :")
            TextField("Masukan nama produk", text: $namaProduk)
        }
        .textFieldStyle(.roundedBorder)
    }
    var satuan : some View{
        HStack{
            Text("Satuan :")
            TextField("Masukan satuan produk", text: $satuanProduk)
            
        }
        .textFieldStyle(.roundedBorder)
    }
    var kategori : some View{
        HStack{
            Text("Kategori :")
            TextField("Masukan kategori produk", text: $kategoriProduk)
        }
        .textFieldStyle(.roundedBorder)
    }
    var harga : some View{
        HStack{
            Text("Harga :")
            TextField("Masukan harga produk", text: $hargaProduk)
                .keyboardType(.numberPad)
        }
        .textFieldStyle(.roundedBorder)
    }
    var jumlah : some View{
        HStack{
            Text("Jumlah :")
            TextField("Masukan jumlah produk", text: $jumlahProduk)
                .keyboardType(.numberPad)
        }
        .textFieldStyle(.roundedBorder)
    }
    
}
