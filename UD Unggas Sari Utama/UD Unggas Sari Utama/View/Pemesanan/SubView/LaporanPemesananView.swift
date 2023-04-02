//
//  LaporanPemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct LaporanPemesananView: View {
    @State var indexTabs = Int()
    @State var selectedDate = Date()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Spacer()
                        .frame(width: geometry.size.width/3, height: 1)
                    Text("Berdasarkan Tanggal : ")
                        .bold()
                        .font(.system(size: 36))
                        .frame(width: geometry.size.width/3, height: 10)
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .scaleEffect(1.5)
                        .frame(width: geometry.size.width/8, height: geometry.size.height/10)
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/6)
                
                HStack(spacing: 80){
                    CardLaporanPemesanan(title: "Produk Terbanyak Di Pesan", hasil: "Ayam Broiller")
                        .frame(width: geometry.size.width/3, height: geometry.size.height/8)
                    CardLaporanPemesanan(title: "Total Pesanan", hasil: "120")
                        .frame(width: geometry.size.width/4.2, height: geometry.size.height/8)
                    CardLaporanPemesanan(title: "Rata-Rata Pesanan", hasil: "120")
                        .frame(width: geometry.size.width/4.2, height: geometry.size.height/8)

                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/3.5)
             
                
                Spacer()
                    .frame(width: geometry.size.width/1, height: geometry.size.height/2.5)
            }
            .navigationTitle("Laporan Pemesanan")
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct LaporanPemesananView_Previews: PreviewProvider {
    static var previews: some View {
        LaporanPemesananView()
    }
}
