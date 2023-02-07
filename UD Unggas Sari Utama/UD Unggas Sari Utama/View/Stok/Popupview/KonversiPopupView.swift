//
//  KonversiPopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct KonversiPopupView: View {
    @State var jumlahSebelum : String = ""
    @State var jumlahSetelah : String = ""
    @Binding var check2: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.1, height: geometry.size.height/1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    
                    title
                        . frame( height: geometry.size.height/8)
                    Text("Ubah dari")
                    PickerProduk()
                        . frame( height: geometry.size.height/6)
                    fieldJumlahSebelum
                        . frame( height: geometry.size.height/6)
                    Text("Menjadi")
                    PickerProduk()
                        . frame( height: geometry.size.height/6)
                    fieldJumlahSetelah
                        . frame( height: geometry.size.height/6)
                    Button(action: generateStokOpname) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("GrayMiddleColor"))
                                . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                .cornerRadius(8)
                                .border(Color.black, width: 2)
                            Text("OK")
                                .bold()
                                .font(.title)
                        }
                        . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                    }  
                }
                .frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension KonversiPopupView {
    var title : some View{
        Text("Stok Opname")
            .bold()
            .font(.system(size: 40))
    }
     var fieldJumlahSebelum : some View{
         HStack{
             Text("Jumlah :")
             TextField("", text: $jumlahSebelum)
         }
         .textFieldStyle(.roundedBorder)
     }
    var fieldJumlahSetelah : some View{
        HStack{
            Text("Jumlah :")
            TextField("", text: $jumlahSetelah)
        }
        .textFieldStyle(.roundedBorder)
    }

}
