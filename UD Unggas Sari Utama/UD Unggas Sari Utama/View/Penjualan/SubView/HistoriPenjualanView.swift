//
//  HistoriPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct HistoriPenjualanView: View {
    @ObservedObject var viewModelPenjualan = FethcerPenjualan()
    @ObservedObject var vmProduk = ProdukFetcher()
    @Binding var checkDetail: Bool
    let dateFormatter = DateFormatter()
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    @State var viewDetail: Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    HStack {
                        Text("No Penjualan")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        Text("Total Harga")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        Text("Tanggal")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        Text("Opsi")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    ScrollView {
                        ForEach(viewModelPenjualan.dataPenjualan, id: \.penjualan_id) { data in
                                HStack {
                                    Text(data.penjualan_id)
                                        .frame(maxWidth: .infinity)
                                    Text(numberFormatter.string(from: NSNumber(value: data.total_harga)) ?? "")
                                        .frame(maxWidth: .infinity)
                                    Text(dateFormatter.string(from: data.tanggal_penjualan))
                                        .frame(maxWidth: .infinity)
                                    Button(action: {
                                        self.checkDetail = true
                                        viewModelPenjualan.selectedPenjualan = data
                                       
                                    }) {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color("OrangeColorSet"))
                                                .frame(width: 80, height: 40)
                                            Text("Detail")
                                                .font(.title3)
                                                .bold()
                                                .foregroundColor(.black)
                                        }
                                    }.frame(maxWidth: .infinity)
                                }
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(8)
                            }
                        
                    }
                    .background(Color("GrayContentColor"))
                }
                .frame(width: geometry.size.width/1.05, height: geometry.size.height/1.25)
                .navigationTitle("Laporan Penjualan")
                .navigationBarTitleDisplayMode(.inline)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                    .shadow(radius: 1))
                .onAppear {
                    dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
                    viewModelPenjualan.fetchData()
                }
                
//                if checkDetail == true {
//                    DetailPenjualanView(penjualan: viewModelPenjualan.selectedPenjualan!, dataDetailPenjualan: viewModelPenjualan.selectedDetail!, dataProduk: vmProduk, close: $checkDetail)
//                        .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.75)
//                }
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}
