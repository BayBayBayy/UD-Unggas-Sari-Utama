//
//  LaporanPemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct LaporanPemesananView: View {
    @ObservedObject var viewModel = FetchPemesanan()
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
                
                HStack(spacing: 80) {
                    CardDetailPenjualan(title: "Nama Produk Laris", value: viewModel.namaProdukLaris)
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                    CardDetailPenjualan(title: "Total Transaksi", value: "\(viewModel.totalTransaksi(for: selectedDate).formattedAsCurrency())")
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                    CardDetailPenjualan(title: "Rata-Rata Transaksi", value: "\(viewModel.rataTransaksi(for: selectedDate).formattedAsCurrency)")
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                }

                .frame(width: geometry.size.width/1, height: geometry.size.height/3.5)
                
                if viewModel.dataPemesanan.isEmpty {
                    ProgressView()
                } else {
                    ChartPemesananView(data: viewModel.dataChartProduk, selectedDate: selectedDate)
                        .frame(width: geometry.size.width/1.5, height: geometry.size.height/2.5)
                        .background(Color("GrayContentColor"))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                            .shadow(radius: 1))
                }
                
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    viewModel.fetchData()
                }
            }
            .onChange(of: selectedDate) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    viewModel.fetchData()
                    viewModel.generateChartData(for: newValue)
                }
            }
            .navigationTitle("Laporan Pemesanan")
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

extension Double {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

