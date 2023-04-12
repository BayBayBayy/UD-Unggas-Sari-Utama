//
//  CardDetailPenjualan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/04/23.
//

import SwiftUI

struct CardDetailPenjualan: View {
    let title: String
    let value: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("GrayMiddleColor"))
            VStack{
                Text(title)
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top)
                Spacer()
                Text(value)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.bottom)
                
            }
        }
    }
}


