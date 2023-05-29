//
//  StockView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI
struct StockView: View {
    @State var keyValueButton = Int()
    @State var isRefreshing = false
    @State var check: Bool = false
    @State var selectedSortBy: String = ""
    @ObservedObject var viewModel = ProdukFetcher()
    @State var checkShort: Bool = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    ZStack{
                        VStack{
                            SortProdukView(viewModel: viewModel, selectedSortBy: $selectedSortBy, checkShort: $checkShort)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/10, alignment: .bottom)
                            DataProdukView(selectedSortBy: $selectedSortBy, checkShort: $checkShort)
                                .frame(width: geometry.size.width/1.05, height: geometry.size.height/1.9)
                                .background(Color("GrayContentColor"))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                                    .shadow(radius: 1))
                            TabButtonActionStok(check: $check, valuePopup: $keyValueButton)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/10, alignment: .bottom)
                            Spacer()
                                .frame(height: geometry.size.height/14)
                        }
                        .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .background(Color("GrayBackgroundColor"))
                        .navigationTitle("Stok")
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                dismiss()
                            })

                        if self.check == true{
                            Spacer()
                                .background(.gray)
                                .opacity(0.5)
                                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        }
                        
                        if self.check == true && keyValueButton == 1{
                            StokOpnamePopupView(check1: $check)
                                .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.75)
                        }else if self.check == true && keyValueButton == 2{
                            NewProductPopupView(check3: $check)
                                .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.35)
                        }else if self.check == true && keyValueButton == 3{
                            KonversiPopupView( check2: $check, viewModelDataProduk: viewModel)
                                .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.65)
                        }
                        
                    }
                    .onChange(of: check){newValue in 
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            viewModel.fetchData()
                        }
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
}
extension Notification.Name {
    static let refreshData = Notification.Name("refreshData")
}


