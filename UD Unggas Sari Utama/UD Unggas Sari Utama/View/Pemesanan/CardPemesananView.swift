//
//  CardPemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 09/02/23.
//

import SwiftUI

struct CardPemesananView: View {
    @ObservedObject var pemesananVM = FetchPemesanan()
    @ObservedObject var vmProduk = ProdukFetcher()
    @Binding private var selectedPemesanan: PemesananResponseModel?
    @Binding var popUp: Bool
    let dateFormatter = DateFormatter()
    @State var checkEdit: Bool = false
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    init(pemesananVM: FetchPemesanan = FetchPemesanan(), vmProduk: ProdukFetcher = ProdukFetcher(), selectedPemesanan: Binding<PemesananResponseModel?>, popUp: Binding<Bool>) {
        self.pemesananVM = pemesananVM
        self.vmProduk = vmProduk
        self._selectedPemesanan = selectedPemesanan
        self._popUp = popUp
    }
    
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
                            if card.status == false{
                                cardPView(cards: card, selectedPemesanan: $selectedPemesanan, check: $popUp)
                                    .onTapGesture {
                                        pemesananVM.selectPemesanan(card)
                                    }
                                    .frame(width: geometry.size.width/4.5, height: geometry.size.height/3)
                                    .padding()
                            }
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear {
                dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    pemesananVM.fetchData()
                    pemesananVM.fetchDataDetail()
                    
                }
            }
            .onChange(of: popUp){ newValue in
                dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    pemesananVM.fetchData()
                    pemesananVM.fetchDataDetail()
                    
                }
                dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
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
    @Binding private var selectedPemesanan: PemesananResponseModel?
    @Binding var check: Bool
    
    let dateFormatter = DateFormatter()
    @State var checkEdit: Bool = false
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: cards.tanggal_pengambilan)

    }
    
    init(cards: PemesananResponseModel, selectedPemesanan: Binding<PemesananResponseModel?>, check: Binding<Bool>) {
        self.cards = cards
        self._selectedPemesanan = selectedPemesanan
        self._check = check
    }
    var body: some View{
        GeometryReader{ geometry in
            
            Button {
                self.check.toggle()
                selectedPemesanan = cards
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .padding()
                    VStack(spacing: 0){
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.3)
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("GrayBackgroundColor"))
                            .frame(width: geometry.size.width/1, height: geometry.size.height/3)
                            .padding(.top)
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("OrangeColorSet"))
                            .frame(width: geometry.size.width/1, height: geometry.size.height/3)
                            .padding(.bottom, 50)
                    } .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                    VStack{
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/8)
                        Text(cards.nama_pembeli)
                            .multilineTextAlignment(.leading)
                            .bold()
                            .font(.system(size: 36))
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
                            .lineLimit(2)
                        
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/4.5)
                        Text(formattedDate)
                            .multilineTextAlignment(.leading)
                            .bold()
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width/1.1, height: geometry.size.height/4.25)
                            .lineLimit(2)
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
            .onTapGesture {
                selectedPemesanan = cards
            }
            .onAppear(){
                dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
            }
        }
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea()
    }
}
