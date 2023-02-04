//
//  HomeView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct HomeView: View {
    @State var favoriteCards: [produkDummy] = produkDummy.sampleData
    
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        Spacer()
                            .frame(width: geometry.size.width/14, height: geometry.size.height/14)
                            .background(.yellow)
                        HStack{
                            scrollProdukView()
                                .frame(width: geometry.size.width/1.5, height: geometry.size.height/1.75)
                            Spacer()
                                .frame(width: 10)
                            Spacer()
                                .frame(width: geometry.size.width/3.5, height: geometry.size.height/1.75)
                                .background(.green)
                        }.frame(width: geometry.size.width/1, height: geometry.size.height/1.75)
                        Spacer()
                            .frame(width: 10, height: geometry.size.height/4)
                            .background(.red)
                    }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .navigationTitle("UD. Amerta Yoga")
                }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
            }
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
        } else{
            // not allowed
        }
    }
}

struct scrollProdukView : View{
    @State var favoriteCards: [produkDummy] = produkDummy.sampleData
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                ScrollView{
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 10){
                        ForEach(favoriteCards, id:\.self){ card in
                            cardView(card: card)
                                .frame(width: geometry.size.width/3.5, height: geometry.size.height/4)
                                .padding(.bottom,25)
                            
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255), lineWidth: 1)
                    .shadow(radius: 1))
            
        }.edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
    }
}

struct cardView : View{
    var card: produkDummy
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                VStack{
                    Image(card.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/2.2, height: geometry.size.height/2)
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2)
                Text(card.nama)
                    .multilineTextAlignment(.leading)
                    .font(.title3)
                    .frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
                    .background(.orange)
                    .lineLimit(2)
            }
            .background(Color(uiColor: .tertiarySystemBackground))
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                .shadow(radius: 1))
            .padding([.top, .horizontal])
        }.edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
    }
}

