//
//  TambahkanPesananPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 06/02/23.
//

import SwiftUI

struct TambahkanPesananPopupView: View {
    @EnvironmentObject var viewModel: PemesananViewModel
    @EnvironmentObject var penjualanViewModel: PenjualanViewModel
    @State var namaPemesan: String = ""
    @State var noHp: String = ""
    @State var dpDibayar: String = ""
    @State var selectedDate = Date()
    @Binding var pesananPopUp: Bool
    
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
                    
                    HStack{
                        Button{
                            pesananPopUp = false
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
                            self.pesananPopUp.toggle()
                            let noHpInt = Int(noHp) ?? 0
                            let dpDibayarInt = Int(dpDibayar) ?? 0
                            penjualanViewModel.tambahPemesanan(namaPembeli: namaPemesan, nohp: noHpInt, dp: dpDibayarInt, tanggalAmbil: selectedDate)
                            penjualanViewModel.clearDetailPenjualanList()
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
            }.frame( width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
        
    }
}

extension TambahkanPesananPopupView{
    var title : some View{
        Text("Pesanan")
            .bold()
            .font(.system(size: 40))
    }
    var nama : some View{
        HStack{
            Text("Nama :")
            TextField("", text: $namaPemesan)
        }
        .textFieldStyle(.roundedBorder)
    }
   var no : some View{
       HStack{
           Text("No HP :")
           TextField("", text: $noHp)
       }
       .textFieldStyle(.roundedBorder)
   }
    var dp : some View{
        HStack{
            Text("DP Dibayar :")
            TextField("", text: $dpDibayar)
                .keyboardType(.numberPad)
        }
        .textFieldStyle(.roundedBorder)
    }
    var tanggal : some View{
        HStack{
            Text("Tanggal Prngambilan :")
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
        }
        .textFieldStyle(.roundedBorder)
    }
}

func generatePesanan(){
    
}
