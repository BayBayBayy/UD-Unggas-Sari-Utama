//
//  LaporanPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct LaporanPenjualanView: View {
    @State var tabSelect = Int()
    @StateObject var salesData = FethcerPenjualan()
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Spacer()
                        .frame(width: geometry.size.width/2.3, height: geometry.size.height/14)
    
                    ButtonShortLaporan(tabIndex: $tabSelect)
                        .frame(width: geometry.size.width/2, height: geometry.size.height/14)
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/6)
             
                
                HStack(spacing: 80){
                    cardLaporanPenjualan(title: "Total Revenue", hasil: "1.200.000")
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                    cardLaporanPenjualan(title: "Total Transaksi", hasil: "120")
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                    cardLaporanPenjualan(title: "Rata-Rata Transaksi", hasil: "100.000")
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)

                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/3.5)
                
                ChartPenjualanView(data: salesData.dataChartProduk)
                    .frame(width: geometry.size.width/1.5, height: geometry.size.height/2.5)
                    .background(Color("GrayContentColor"))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                        .shadow(radius: 1))
            }
            .onAppear(){
                salesData.fetchData()
            }
            .background(Color("GrayBackgroundColor"))
            .navigationTitle("Laporan Penjualan")
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct LaporanPenjualanView_Previews: PreviewProvider {
    static var previews: some View {
        LaporanPenjualanView()
    }
}
