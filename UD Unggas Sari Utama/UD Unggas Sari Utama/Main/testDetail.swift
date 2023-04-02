//
//  testDetail.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 02/04/23.
//

import SwiftUI

struct testDetail: View {
    @ObservedObject var viewModelPenjualan = FetchPemesanan()
    
    var body: some View {
        ForEach(viewModelPenjualan.detailPemesanan, id: \.id){ detail in
            HStack{
                Text("id")
                Text(detail.id)
                Text("total")
                Text("\(detail.sub_harga)")
            }
            
        }
        .onAppear(){
            viewModelPenjualan.fetchDataDetail()
        }
    }
}

struct testDetail_Previews: PreviewProvider {
    static var previews: some View {
        testDetail()
    }
}
