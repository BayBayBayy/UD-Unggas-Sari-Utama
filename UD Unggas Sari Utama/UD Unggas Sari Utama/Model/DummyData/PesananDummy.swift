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
}

extension pesananDummy{
    static var sampleData: [pesananDummy] =
    [pesananDummy(nama: "Pak yan", urutanPesanan: "#1"),
     pesananDummy(nama: "pak tut", urutanPesanan: "#2"),
     pesananDummy(nama: "pak man", urutanPesanan: "#3"),
     pesananDummy(nama: "pak ngah", urutanPesanan: "#4")]
}
