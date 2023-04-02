//
//  ButtonShortLaporan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 23/02/23.
//

import SwiftUI

struct ButtonShortLaporan: View {
    @Binding var tabIndex: Int
    
    var body: some View {
        HStack{
            buttonView(isSelect: .constant(tabIndex == 0), title: "Hari Ini")
                .onTapGesture { onButtonTapped(index: 0) }
            buttonView(isSelect: .constant(tabIndex == 1), title: "Minggu Ini")
                .onTapGesture { onButtonTapped(index: 1) }
            buttonView(isSelect: .constant(tabIndex == 2), title: "Bulan Ini")
                .onTapGesture { onButtonTapped(index: 2) }
        }
    }
}
extension ButtonShortLaporan{
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}



struct buttonView: View{
    @Binding var isSelect: Bool
    private let title: String
    
    init(isSelect: Binding<Bool>, title: String) {
        self._isSelect = isSelect
        self.title = title
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelect ?  Color("OrangeColorSet") : .white)
            Text(title)
                .foregroundColor(.black)
                .bold()
                
        }
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color("OrangeColorSet"),
                                                             lineWidth: 3))
    }
}


struct cardLaporanPenjualan: View{
    private let title: String
    private let hasil: String
    
    init(title: String, hasil: String) {
        self.title = title
        self.hasil = hasil
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("GrayContentColor"))
            VStack{
                Text(title)
                    .foregroundColor(.gray)
                    .font(.title2)
                    .bold()
                    .padding()
                Spacer()
                Text(hasil)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    .padding()
            }
        }
    }
}
