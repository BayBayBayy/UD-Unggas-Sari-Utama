//
//  PenjualanModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 25/01/23.
//

import Foundation

struct detailPenjualan{
    var id = UUID()
    var penjualanId = UUID()
    var nama : String
    var jumlahProduk : Int
    var harga : Int
    var subHarga : Int
    var totalHarga : Int
}
