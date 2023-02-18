//
//  test.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/02/23.
//

import SwiftUI

struct test: View {
    @ObservedObject var viewModel = ProdukFetcher()
        
        var body: some View {
            NavigationStack{
                List(viewModel.produk) { item in
                    VStack(alignment: .leading) {
                        Text(item.nama_produk)
                            .font(.headline)
                        Text("$\(item.harga)")
                            .font(.subheadline)
                    }
                }
                .navigationBarTitle("Items")
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
