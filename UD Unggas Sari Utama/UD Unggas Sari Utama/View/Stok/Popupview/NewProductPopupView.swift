//
//  NewProductPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 05/02/23.
//

import SwiftUI

struct NewProductPopupView: View {
    @State var namaProduk : String = ""
    @State var satuanProduk : String = ""
    @State var kategoriProduk : String = ""
    @State var hargaProduk : String = ""
    @State var jumlahProduk : String = ""
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
                    harga
                        . frame( height: geometry.size.height/8)
                    jumlah
                        . frame( height: geometry.size.height/8)
                    Button(action: generateStokOpname) {
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
   var harga : some View{
       HStack{
           Text("Harga :")
           TextField("", text: $hargaProduk)
       }
       .textFieldStyle(.roundedBorder)
   }
   var jumlah : some View{
       HStack{
           Text("Jumlah :")
           TextField("", text: $jumlahProduk)
       }
       .textFieldStyle(.roundedBorder)
   }

}
