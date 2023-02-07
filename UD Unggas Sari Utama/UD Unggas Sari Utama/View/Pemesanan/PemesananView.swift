//
//  PemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/01/23.
//

import SwiftUI

struct PemesananView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            GeometryReader{ geometry in
                NavigationStack{
                    VStack{
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/10)
                        ButtonPemesananView()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/14, alignment: .bottom)
                        Spacer()
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.3)
                            .background(.blue)
                    }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
                        .navigationTitle("Pesanan")
                }
                .frame(width: geometry.size.width/1, height: geometry.size.height/1)
                .background(Color("GrayBackgroundColor"))
            }
            
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea()
            
            
        } else{
            // not allowed
        }
    }
}

struct PemesananView_Previews: PreviewProvider {
    static var previews: some View {
        PemesananView()
    }
}
