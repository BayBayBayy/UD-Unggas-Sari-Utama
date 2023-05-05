//
//  LaporanPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct LaporanPenjualanView: View {
    @State var tabSelect = Int()
    @ObservedObject var viewModel = FethcerPenjualan()
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
                    CardDetailPenjualan(title: "Total Revenue", value: viewModel.totalTransaksi(for: selectedDate).formattedAsCurrency())
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                    CardDetailPenjualan(title: "Jumlah Transaksi", value: "\(viewModel.jumlahTransaksi(for: selectedDate)) Transaksi")
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                    CardDetailPenjualan(title: "Rata-Rata Transaksi", value: viewModel.rataTransaksi(for: selectedDate).formattedAsCurrency)
                        .frame(width: geometry.size.width/4, height: geometry.size.height/8)
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/3.5)
                
                if viewModel.dataPenjualan.isEmpty {
                    ProgressView()
                } else {
                    ChartPenjualanView(data: viewModel.dataChartProduk, selectedDate: selectedDate)
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
                    viewModel.fetchDataDetail()
                }
            }
            .onChange(of: selectedDate) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    viewModel.fetchData()
                    viewModel.generateChartData(for: newValue)
                }
            }
            .background(Color("GrayBackgroundColor"))
            .navigationTitle("Laporan Penjualan")
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}
extension Double {
    var formattedAsCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: self as NSNumber) ?? ""
    }
}

extension Int {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}


struct LaporanPenjualanView_Previews: PreviewProvider {
    static var previews: some View {
        LaporanPenjualanView()
    }
}
