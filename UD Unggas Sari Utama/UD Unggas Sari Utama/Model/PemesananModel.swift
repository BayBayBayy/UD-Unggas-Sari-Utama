//
//  PemesananModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 25/01/23.
//

import Foundation

struct pemesanan {
    var id = UUID()
    var detailPemesananId = UUID()
    var totalHarga : Int
    var namaPembeli : String
    var noHP : String
    var dpDibayar : Int
    var dpSisa : Int
    var tanggalPemesanan : Date
    var tanggalPengambilan : Date
}

struct detailPemesanan{
    var id = UUID()
    var pemesananId = UUID()
    var namaProduk : String
    var jumlahProduk : Int
    var harga : Int
    var subHarga : Int
    var totalHarga : Int
}
