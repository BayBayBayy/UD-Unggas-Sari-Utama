//
//  CardPemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 09/02/23.
//

import SwiftUI

struct CardPemesananView: View {
    @State var dummy: [pesananDummy] = pesananDummy.sampleData
    @State var check: Bool = false
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
                        ForEach(dummy, id:\.self){ card in
                            
                            cardPView(card: card, check: $check)
                                .frame(width: geometry.size.width/3.5, height: geometry.size.height/4)
                                .padding()
                            
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
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
    var card: pesananDummy
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
                        Text(card.urutanPesanan)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
                            .lineLimit(2)
 
                        Text(card.nama)
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
