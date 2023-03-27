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
    @Binding var cancelList: Bool
    @EnvironmentObject var penjualanViewModel: PenjualanViewModel
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
                    .frame(width: cancelList ? geometry.size.width/2.25 : geometry.size.width/1.75)
                
                if cancelList == true {
                    Button {
                        self.cancelList.toggle()
                        penjualanViewModel.clearDetailPenjualanList()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.red)
                                .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                            VStack {
                                Text("Batal")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                    .bold()
                                    .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        .cornerRadius(8)
                    }
                }
                
                Button {
                    self.checkOk.toggle()
                    buttonValue = 1
                    penjualanViewModel.checkout()
                    penjualanViewModel.clearDetailPenjualanList()
                    cancelList = false
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(cancelList ? Color.green : Color.gray)
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
                }.disabled(cancelList ? false : true )
                
            }.frame(width: geometry.size.width/1, height: geometry.size.height/8)
        }.ignoresSafeArea(.all)
    }
}

