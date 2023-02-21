//
//  StokOpnamePopupView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 03/02/23.
//

import SwiftUI

struct StokOpnamePopupView: View {
    @State var jumlah : String = ""
    @State var keterangan : String = ""
    @Binding var check1: Bool
    @ObservedObject var viewModel = ProdukFetcher()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.1, height: geometry.size.height/1)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    title
                        . frame( height: geometry.size.height/8)
                    PickerProduk(viewModel: viewModel)
                        . frame( height: geometry.size.height/6)
                    choiceSituation
                        . frame( height: geometry.size.height/6)
                    fieldJumlah
                        . frame( height: geometry.size.height/6)
                    fieldKeterangan
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
                }.frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            }.frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }.edgesIgnoringSafeArea(.all)
    }
}

 extension StokOpnamePopupView {
    var title : some View{
        Text("Stok Opname")
            .bold()
            .font(.system(size: 40))
    }
    var choiceSituation : some View{
        HStack{
            Text("Produk :")
            RadioButtonGroups { selected in
                print("Selected Gender is: \(selected)")
            }
            Spacer()
        }
    }
     var fieldJumlah : some View{
         HStack{
             Text("Jumlah :")
             TextField("", text: $jumlah)
         }
         .textFieldStyle(.roundedBorder)
         .keyboardType(.numberPad)
    
     }
     var fieldKeterangan : some View{
         HStack{
             Text("Keterangan :")
             TextField("", text: $keterangan)
         }
         .textFieldStyle(.roundedBorder)
     }
}

func generateStokOpname() {
    
}
