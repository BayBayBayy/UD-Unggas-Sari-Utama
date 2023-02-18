//
//  test.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/02/23.
//

import SwiftUI

struct test: View {
    @StateObject var viewModel = ProdukViewModel(produkFetcher: ProdukFetcher())
        
        var body: some View {
            List(viewModel.dataTest) { produk in
                VStack(alignment: .leading) {
                    Text(produk.nama_produk)
                    Text("Rp. \(produk.harga)")
                }
            }
            .onAppear {
                viewModel.fetchProduk()
            }
        }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
