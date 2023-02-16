//
//  PemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct PemesananView: View {
    @State var favoriteCards: [pesananDummy] = pesananDummy.sampleData
    @State var checkPemesanan: Bool = false

    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    ZStack{
                        VStack{
                            ButtonPemesananView()
                                .frame(width: geometry.size.width/1, height: geometry.size.height/12, alignment: .bottom)
                            CardPemesananView(check: $checkPemesanan)
                                .frame(width: geometry.size.width/1.05, height: geometry.size.height/1.5)
                            Spacer()
                                .frame(width: geometry.size.width/1, height: geometry.size.height/15, alignment: .bottom)
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
                            DetailPesananPopupview()
                                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        }
                        
                    }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
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
