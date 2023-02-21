//
//  TambahBarangPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 11/02/23.
//

import SwiftUI

struct TambahBarangPopupView: View {
    @State var jumlahBarang: String = ""
    
    var produk: ProdukResponseModel
    @Binding var isPresented: ProdukResponseModel?
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
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
                            .frame(width: geometry.size.width/6)
                        Spacer()
                    }.frame( height: geometry.size.height/7)
                    
                    Button(action: {
                        self.isPresented = nil
                    }, label: {
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
                    })
                }.frame( width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            }.frame( width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

extension TambahBarangPopupView{
    var title : some View{
        Text("Tambahkan ke List Belanja")
            .bold()
            .font(.system(size: 40))
    }
    var jumlah : some View{
        HStack{
            Text("jumlah :")
            TextField("", text: $jumlahBarang)
        }
        .textFieldStyle(.roundedBorder)
    }
}
