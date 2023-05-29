//
//  SortProdukView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 28/05/23.
//

import SwiftUI

struct SortProdukView: View {
    var  viewModel: ProdukFetcher
    @Binding var selectedSortBy: String
    @Binding var checkShort: Bool
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer()
                    .frame(width: geometry.size.width/4.5, height: geometry.size.height/1)
                HStack{
                    Text("Urutkan Berdasarkan : ")
                        .bold()
                        .font(.system(size: 24))
                        .frame(width: geometry.size.width/4, height: 14)
                    
                    SortProduk(selectedSortBy: $selectedSortBy, viewModel: viewModel)
                        .frame(width: geometry.size.width/3.5, height: geometry.size.height/1)
                    
                    Spacer()
                        .frame(width: geometry.size.width/24)
                    
                    Button {
                        viewModel.fetchDataSort(sortBy: selectedSortBy)
                        self.checkShort.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("OrangeColorSet"))
                                .frame(width: geometry.size.width/5.5, height: geometry.size.height/2)
                            
                            VStack {
                                Text("Urutkan")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(width: geometry.size.width/10, height: geometry.size.height/16)
                            }
                        }
                        .frame(width: geometry.size.width/8, height: geometry.size.height/1.5)
                        .cornerRadius(20)
                    }
                }
                .frame(width: geometry.size.width/2, height: geometry.size.height/1)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
        }
    }
}
