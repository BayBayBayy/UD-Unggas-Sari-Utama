//
//  DetailPenjualanModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/03/23.
//

import Foundation

struct DetailPenjualanModel: Codable, Identifiable, Hashable{
    var id: String
    var penjualan_id: String
    var produk_id: String
    var jumlah: Int
    var harga: Int
    var subTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case id,
             penjualan_id,
             produk_id,
             jumlah,
             harga,
             subTotal
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        penjualan_id = try values.decode(String.self, forKey: .penjualan_id)
        produk_id = try values.decode(String.self, forKey: .produk_id)
        let jumlahString = try values.decode(String.self, forKey: .jumlah)
        jumlah = Int(jumlahString) ?? 0
        let hargaString = try values.decode(String.self, forKey: .harga)
        harga = Int(hargaString) ?? 0
        let totalString = try values.decode(String.self, forKey: .subTotal)
        subTotal = Int(totalString) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(penjualan_id, forKey: .penjualan_id)
        try container.encode(produk_id, forKey: .produk_id)
        try container.encode(jumlah, forKey: .jumlah)
        try container.encode(harga, forKey: .harga)
        try container.encode(subTotal, forKey: .subTotal)
    }
}
