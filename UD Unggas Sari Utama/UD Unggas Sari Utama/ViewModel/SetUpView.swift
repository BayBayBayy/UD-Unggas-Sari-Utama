//
//  SetUpView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 19/02/23.
//

import SwiftUI

struct SetUpView: View {
    @ObservedObject var viewModel = ProdukFetcher()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SetUpView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpView()
    }
}
