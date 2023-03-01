//
//  HomeView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct HomeView: View {
    @State var favoriteCards: [produkDummy] = produkDummy.sampleData
    @State var check: Bool = false
    @State var checkCard: Bool = false
    @State var checkPesanan: Bool = false
    @State var value = Int()
    
    @ObservedObject var viewModel = ProdukFetcher()
    @State private var selectedProduk: ProdukResponseModel?
    
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    ZStack{
                        VStack{
                            Spacer()
                                .frame(width: geometry.size.width/14, height: geometry.size.height/14)
                            
                            HStack{
                                CardProdukView(produkVM: viewModel, selectedProduk: $selectedProduk, check: $checkCard)
                                    .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.75)
                                Spacer()
                                    .frame(width: 10)
                                ShoppingChartView(showPesanan: $checkPesanan)
                                    .frame(width: geometry.size.width/2.75, height: geometry.size.height/1.75)
                                    .background(Color("GrayContentColor"))
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                                        .shadow(radius: 1))
                            }.frame(width: geometry.size.width/1, height: geometry.size.height/1.75)
                            
                            Spacer()
                                .frame(height: geometry.size.height/16)
                            
                            ButtonView(checkOk: $check, buttonValue: $value)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/6)
                        }
                        .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .background(Color("GrayBackgroundColor"))
                        .navigationTitle("UD. Amerta Yoga")
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                dismiss()
                                dismissPesanan()
                                dismissCard()
                            })
                        
                        // Blur View
                        if self.check == true{
                            Spacer()
                                .background(.gray)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        }else if self.checkPesanan == true{
                            Spacer()
                                .background(.gray)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        }else if self.checkCard == true{
                            Spacer()
                                .background(.gray)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        }
                        
                        // Popup View
                        if self.check == true && value == 1{
                            PembayaranPopupView(close: $check)
                                .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.75)
                        }else if checkPesanan == true{
                            TambahkanPesananPopupView()
                                .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.75)
                        }else if checkCard == true{
//                            TambahBarangPopupView(produk: ProdukResponseModel)
                        }
                        
                        
                    }
                    
                    
                    .onAppear(){
                        self.viewModel.fetchData()
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    
                    
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                .accentColor(Color("OrangeColorSet"))
            }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
        } else{
            // not allowed
        }
    }
    private func dismiss(){
        self.check = false
    }
    private func dismissPesanan(){
        self.checkPesanan = false
    }
    private func dismissCard(){
        self.checkCard = false
    }
}
