//
//  ShoppingChartView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct ShoppingChartView: View {
    @State var showPesanan: Bool = false
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                VStack{
                    Text("Daftar Belanja")
                        .bold()
                        .font(.system(size: 24))
                        .padding(.top)
                    HStack{
                        Text("No")
                            .bold()
                            .font(.system(size: 16))
                        Text("Nama")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/5)
                        Text("Jumlah")
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                        Text("Harga")
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                        Text("Total")
                            .bold()
                            .font(.system(size: 16))
                            .padding()
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/12)
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/6)
                
                ScrollView(){
                    HStack{
                        Text("1")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/10)
                        Text("Ayam Broiler")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/5)
                        Text("2")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/5)
                        Text("12000")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/6)
                        Text("24000")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/5)
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/8)
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2)
                
                VStack{
                    RoundedRectangle(cornerRadius: 0.1)
                        .fill(.black)
                        .frame(width: geometry.size.width/1, height: 2)
                    HStack{
                        Text("Harga Total")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text("24000")
                            .bold()
                            .font(.system(size: 20))
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/10)
                    Spacer()
                        .frame(width: geometry.size.width/1.1, height: geometry.size.height/18)
                    HStack{
                        Text("Pesanan")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Toggle("", isOn: $showPesanan)
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/10)
                    
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
            }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ShoppingChartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingChartView()
    }
}
