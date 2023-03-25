//
//  CardProdukView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 06/02/23.
//

import SwiftUI

struct CardProdukView: View {
    //    @State var favoriteCards: [produkDummy] = produkDummy.sampleData
    @EnvironmentObject var penjualanViewModel: PenjualanViewModel
    @ObservedObject var produkVM = ProdukFetcher()
    @Binding var cloeThis: Bool
    @Binding var cancelList: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    ScrollView{
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10){
                            ForEach(produkVM.produk, id:\.id){ card in
                                
                                cardView(cards: card, selectedProduk: $produkVM.selectedProduk, check: $cloeThis)
                                    .onTapGesture {
                                        self.produkVM.selectProduct(card)
                                    }
                                    .frame(width: geometry.size.width/3.5, height: geometry.size.height/4)
                                    .padding()
                                
                            }
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                
                if self.cloeThis == true{
                    Spacer()
                        .background(.gray)
                        .opacity(0.5)
                        .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                }
                if cloeThis {
                    TambahBarangPopupView(viewModel: _penjualanViewModel, produk: produkVM.selectedProduk!, close: $cloeThis, cancelList: $cancelList)
                        .environmentObject(penjualanViewModel)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.move(edge: .bottom))
                }
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear(){
                self.produkVM.fetchData()
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .background(Color("GrayContentColor"))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                .shadow(radius: 1))
            
        }.edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
    }
}

struct cardView : View{
    //    var card: produkDummy
    var cards: ProdukResponseModel
    @EnvironmentObject var viewModel: ProdukFetcher
    @Binding private var selectedProduk: ProdukResponseModel?
    @Binding var check: Bool
    
    init(cards: ProdukResponseModel, selectedProduk: Binding<ProdukResponseModel?>, check: Binding<Bool>) {
        self.cards = cards
        self._selectedProduk = selectedProduk
        self._check = check
    }
    
    
    var body: some View{
        GeometryReader{ geometry in
            
            Button {
                viewModel.selectProduct(cards)
                selectedProduk = cards
                self.check.toggle()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .padding()
                    VStack{
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.5)
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("OrangeColorSet"))
                            .frame(width: geometry.size.width/1, height: geometry.size.height/3)
                            .padding()
                    } .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    VStack{
                        Image(cards.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/2.2, height: geometry.size.height/2)
                        
                        Text(cards.nama_produk)
                            .multilineTextAlignment(.leading)
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
                            .lineLimit(2)
                    }
                    .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
            }
            .onTapGesture {
                selectedProduk = cards
            }
        }
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
}
