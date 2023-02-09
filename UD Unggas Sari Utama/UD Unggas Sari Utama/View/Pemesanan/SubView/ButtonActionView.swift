//
//  ButtonActionView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 09/02/23.
//

import SwiftUI

struct ButtonActionView: View {
    @State var check: Bool = false
    var body: some View {
        GeometryReader{ geometry in
            Button {
                self.check.toggle()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("OrangeColorSet"))
                        .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                       
                    VStack {
                        Text("Stok Opname")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .bold()
                            .frame(width: geometry.size.width/8, height: geometry.size.height/16)
                    }
                }
                .frame(width: geometry.size.width/8, height: geometry.size.height/3.5)
                .cornerRadius(8)
            }
        }
    }
}

struct ButtonActionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionView()
    }
}
