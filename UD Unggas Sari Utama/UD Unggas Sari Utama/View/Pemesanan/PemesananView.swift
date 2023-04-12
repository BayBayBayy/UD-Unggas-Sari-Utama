//
//  PemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct PemesananView: View {
    @State var checkPemesanan: Bool = false
    @ObservedObject var VM = FetchPemesanan()
    @ObservedObject var vmProduk = ProdukFetcher()
    @EnvironmentObject var viewModel : PemesananViewModel
    let dateFormatter = DateFormatter()
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    ZStack{
                        VStack{
                            ButtonPemesananView()
                                .frame(width: geometry.size.width/1, height: geometry.size.height/12, alignment: .bottom)
                            CardPemesananView( selectedPemesanan: $VM.selectedPemesanan, popUp: $checkPemesanan)
                                .frame(width: geometry.size.width/1.05, height: geometry.size.height/1.5)
                            Spacer()
                                .frame(width: geometry.size.width/1, height: geometry.size.height/15, alignment: .bottom)
                        }
                        .onChange(of: checkPemesanan){ newValue in
                            dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                VM.fetchData()
                                VM.fetchDataDetail()
                            }
                        }
                        .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                            .navigationTitle("Pesanan")
                            .simultaneousGesture(
                                TapGesture().onEnded {
                                    dismissPopup()
                                })
                        
                        // blur View
                        if self.checkPemesanan == true{
                            Spacer()
                                .background(.gray)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        }
                        
//                        popup view
                        if self.checkPemesanan == true{
                            let saleDetail = VM.detailPemesanan.filter { $0.pemesanan_id == VM.selectedPemesanan!.pemesanan_id }
                            DetailPesananPopupview(dataProduk: vmProduk, close: $checkPemesanan, pemesanan: VM.selectedPemesanan!, dataDetailPemesnan: saleDetail)
                                .frame(width: geometry.size.width/1.3, height: geometry.size.height/1.2)
                        }
                        
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                .background(Color("GrayBackgroundColor"))
                .accentColor(Color("OrangeColorSet"))
            }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
        } else{
            // not allowed
        }
    }
    private func dismissPopup(){
        self.checkPemesanan = false
    }
}
