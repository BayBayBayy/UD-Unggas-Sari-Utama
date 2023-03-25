//
//  NewProductPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 05/02/23.
//

import SwiftUI

struct NewProductPopupView: View {
    let vmCreateProduk = ProdukManager()
    @ObservedObject var viewModel = ProdukFetcher()
    @State var id : String = " "
    @State var namaProduk : String = ""
    @State var satuanProduk : String = ""
    @State var kategoriProduk : String = ""
    @State var hargaProduk : String = ""
    @State var image: String = ""
    @State var jumlahProduk : String = ""
    @State var ecer: Bool = false
    @State var tanggal: Date = Date()
    @Binding var check3: Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.2, height: geometry.size.height/1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    
                    title
                        . frame( height: geometry.size.height/6)
                    nama
                        . frame( height: geometry.size.height/8)
                    satuan
                        . frame( height: geometry.size.height/8)
                    kategori
                        . frame( height: geometry.size.height/8)
                    gambar
                        . frame( height: geometry.size.height/8)
                    harga
                        . frame( height: geometry.size.height/8)
                    jumlah
                        . frame( height: geometry.size.height/8)
                    CheckToggle(isOn: $ecer, title: "Bisa Ecer")
                    DatePicker("Tanggal Produk", selection: $tanggal, displayedComponents: [.date])
                    
                    HStack{
                        Button{ vmCreateProduk.simpanProduk(id: id, nama_produk: namaProduk, satuan: satuanProduk, produk_kategori: kategoriProduk, image: image, harga: hargaProduk, jumlah_produk: jumlahProduk, produk_ecer: ecer, tanggal_masuk_produk: tanggal){ response in
                            if response != nil {
                                print("Data berhasil disimpan")
                            } else {
                                print("Terjadi kesalahan saat menyimpan data")
                            }
                        }
                            viewModel.fetchData()
                            check3.toggle()
                            
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
            }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
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
    var gambar : some View{
        HStack{
            Text("gambar :")
            TextField("", text: $image)
        }
        .textFieldStyle(.roundedBorder)
    }
   var harga : some View{
       HStack{
           Text("Harga :")
           TextField("", text: $hargaProduk)
               .keyboardType(.numberPad)
       }
       .textFieldStyle(.roundedBorder)
   }
   var jumlah : some View{
       HStack{
           Text("Jumlah :")
           TextField("", text: $jumlahProduk)
               .keyboardType(.numberPad)
       }
       .textFieldStyle(.roundedBorder)
   }

}
