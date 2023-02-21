//
//  ButtonView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/02/23.
//

import SwiftUI

struct ButtonView: View {
    @Binding var checkOk: Bool
    @Binding var buttonValue: Int
    @State var checkDetails: Bool = false

    var body: some View {
        GeometryReader{ geometry in
            HStack{
                NavigationLink {
                    LaporanPenjualanView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("OrangeColorSet"))
                            .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        VStack {
                            Text("Laporan")
                                .foregroundColor(.black)
                                .font(.system(size: 16))
                                .bold()
                                .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                        }
                    }
                    .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                    .cornerRadius(8)
                }
                
                NavigationLink {
                    HistoriPenjualanView(checkDetail: $checkDetails)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("OrangeColorSet"))
                            .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        VStack {
                            Text("Histori")
                                .foregroundColor(.black)
                                .font(.system(size: 16))
                                .bold()
                                .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                        }
                    }
                    .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                    .cornerRadius(8)
                }
                
                Spacer()
                    .frame(width: geometry.size.width/1.75)
                
                Button {
                    self.checkOk.toggle()
                    buttonValue = 1
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green)
                            .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        VStack {
                            Text("Bayar")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                                .bold()
                                .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                        }
                    }
                    .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                    .cornerRadius(8)
                }
                
            }.frame(width: geometry.size.width/1, height: geometry.size.height/8)
        }.ignoresSafeArea(.all)
    }
}

