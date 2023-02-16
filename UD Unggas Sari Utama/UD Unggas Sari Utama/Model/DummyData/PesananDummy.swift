//
//  PesananDummy.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 09/02/23.
//

import Foundation

struct pesananDummy : Hashable {
    var nama: String
    var urutanPesanan: String
    var hargaTotal: String
}

extension pesananDummy{
    static var sampleData: [pesananDummy] =
    [pesananDummy(nama: "Pak yan", urutanPesanan: "#1", hargaTotal: "20000"),
     pesananDummy(nama: "pak tut", urutanPesanan: "#2", hargaTotal: "20000"),
     pesananDummy(nama: "pak man", urutanPesanan: "#3", hargaTotal: "22000"),
     pesananDummy(nama: "pak ngah", urutanPesanan: "#4", hargaTotal: "23000"),
     pesananDummy(nama: "pak ngah", urutanPesanan: "#5", hargaTotal: "25000"),
     pesananDummy(nama: "pak ngah", urutanPesanan: "#6", hargaTotal: "26000")]
}
