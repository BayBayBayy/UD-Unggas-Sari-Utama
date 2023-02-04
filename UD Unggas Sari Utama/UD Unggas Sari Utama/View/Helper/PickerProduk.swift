//
//  PickerProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI

struct PickerProduk: View {
    @State private var selectedStrength = "Ayam Broiller"
    let strengths = ["Ayam Broiller", "Ayam Merah", "Aayam Pejantan"]
    var body: some View {
        HStack{
            Text("Pilih Berdasarkan")
            Picker("Strength", selection: $selectedStrength) {
                ForEach(strengths, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct PickerProduk_Previews: PreviewProvider {
    static var previews: some View {
        PickerProduk()
    }
}
