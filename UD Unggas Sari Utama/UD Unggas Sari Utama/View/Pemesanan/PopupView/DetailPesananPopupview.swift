//
//  DetailPesananPopupview.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct DetailPesananPopupview: View {
    @State var namaPemesan1: String = ""
    @State var noHp1: String = ""
    @State var dpDibayar1: String = ""
    @State var selectedDate1 = Date()
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.1, height: geometry.size.height/1.1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    title
                        .frame( height: geometry.size.height/6)
                    nama
                        .frame( height: geometry.size.height/8)
                    no
                        .frame( height: geometry.size.height/8)
                    dp
                        .frame( height: geometry.size.height/8)
                    tanggal
                        .frame( height: geometry.size.height/8)
                    Button(action: generatePesanan) {
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
            }.frame( width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
        
    }
}

extension DetailPesananPopupview{
    var title : some View{
        Text("Pesanan")
            .bold()
            .font(.system(size: 40))
    }
    var nama : some View{
        HStack{
            Text("Nama :")
            TextField("", text: $namaPemesan1)
        }
        .textFieldStyle(.roundedBorder)
    }
   var no : some View{
       HStack{
           Text("No HP :")
           TextField("", text: $noHp1)
       }
       .textFieldStyle(.roundedBorder)
   }
    var dp : some View{
        HStack{
            Text("DP Dibayar :")
            TextField("", text: $dpDibayar1)
        }
        .textFieldStyle(.roundedBorder)
    }
    var tanggal : some View{
        HStack{
            Text("Tanggal Prngambilan :")
            DatePicker("", selection: $selectedDate1, displayedComponents: .date)
        }
        .textFieldStyle(.roundedBorder)
    }
}
