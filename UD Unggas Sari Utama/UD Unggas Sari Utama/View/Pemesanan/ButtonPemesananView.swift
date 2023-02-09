//
//  ButtonPemesananView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct ButtonPemesananView: View {
    @State var check: Bool = false
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                    .frame(width: geometry.size.width/1.25)
                
                NavigationLink {
                    LaporanPemesananView()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("OrangeColorSet"))
                            .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                        VStack {
                            Text("Laporan")
                                .foregroundColor(.black)
                                .font(.system(size: 16))
                                .bold()
                                .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                        }
                    }
                    .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                    .cornerRadius(8)
                }
            } .frame(width: geometry.size.width/1, height: geometry.size.height/0.65)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ButtonPemesananView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPemesananView()
    }
}
