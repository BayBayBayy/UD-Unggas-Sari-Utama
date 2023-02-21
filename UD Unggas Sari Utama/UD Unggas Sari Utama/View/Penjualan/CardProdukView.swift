//
//  CardProdukView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 06/02/23.
//

import SwiftUI

struct CardProdukView: View {
    //    @State var favoriteCards: [produkDummy] = produkDummy.sampleData
    @ObservedObject var produkVM = ProdukFetcher()
    @State private var selectedProduk: ProdukResponseModel?
    @Binding var check: Bool
    
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
                                
                                cardView(cards: card, check: $check)
                                    .onTapGesture {
                                        self.produkVM.selectProduk(produk: card)
                                    }
                                    .frame(width: geometry.size.width/3.5, height: geometry.size.height/4)
                                    .padding()
                                
                            }
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                
//                if check == true{
//                    TambahBarangPopupView(produk: selectedProduk!, isPresented: self.$produkVM.selectedProduk)
//                }
                
            }.frame(width: geometry.size.width, height: geometry.size.height)
//            .sheet(item: self.$produkVM.selectedProduk) { produk in
//                            TambahBarangPopupView(produk: produk, isPresented: self.$produkVM .selectedProduk)
//                        }
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
    
    @Binding var check: Bool
    var body: some View{
        GeometryReader{ geometry in
            
            Button {
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
        }
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
}
