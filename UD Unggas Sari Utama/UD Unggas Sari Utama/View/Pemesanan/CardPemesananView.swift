//
//  CardPemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 09/02/23.
//

import SwiftUI

struct CardPemesananView: View {
    @ObservedObject var pemesananVM = FetchPemesanan()
    @State var dummy: [pesananDummy] = pesananDummy.sampleData
    @Binding var check: Bool
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                ScrollView{
                    LazyVGrid(columns: columns, alignment: .center, spacing: 10){
                        ForEach(pemesananVM.dataPemesanan, id:\.pemesanan_id){ card in
                            
                            cardPView(cards: card, check: $check)
                                .frame(width: geometry.size.width/4.5, height: geometry.size.height/5)
                                .padding()
                            
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear(){
                self.pemesananVM.fetchData()
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

struct cardPView : View{
    var cards: PemesananResponseModel
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
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/10)
                        Text(cards.nama_pembeli)
                            .multilineTextAlignment(.leading)
                            .bold()
                            .font(.system(size: 36))
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
                            .lineLimit(2)
                        
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/4)
                        Text(cards.pemesanan_id)
                            .multilineTextAlignment(.leading)
                            .bold()
                            .font(.system(size: 24))
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
