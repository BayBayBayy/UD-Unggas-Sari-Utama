//
//  PembayaranPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 11/02/23.
//

import SwiftUI

struct PembayaranPopupView: View {
    @Binding var close: Bool
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.8, height: geometry.size.height/1.8)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    Text("Pembayaran")
                        .bold()
                        .font(.system(size: 40))
                        .frame( height: geometry.size.height/6)
                    Text("Pembayaran ini telah selesai, silahkan lanjut ke pembelian lainnya")
                        .lineLimit(3)
                        .frame(width: geometry.size.width/3, height: geometry.size.height/6)
                    HStack{
                        Button{
                            dismiss()
                        } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("GrayMiddleColor"))
                                . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                .cornerRadius(8)
                                .border(Color.black, width: 2)
                            Text("OK")
                                .bold()
                                .font(.title2)
                        }
                        .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                    }
                        Spacer()
                            .frame( width: geometry.size.width/20)
                        
                        Button(action: pembelianBarang) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    .frame( width: geometry.size.width/5, height: geometry.size.height/12)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("Print Nota")
                                    .bold()
                                    .font(.title2)
                            }
                            .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                    }.frame(width: geometry.size.width/3, height: geometry.size.height/8)
                        .padding(.trailing)
                }.frame( width: geometry.size.width/0.9, height: geometry.size.height/0.9)
            }.frame( width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
    func dismiss(){
        self.close = false
    }
}

func pembelianBarang(){
    
}
