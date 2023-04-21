//
//  DetailPenjualanModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/03/23.
//

import Foundation

struct DetailPenjualanModel: Codable, Hashable{
    var id: String
    var penjualan_id: String
    var produk_id: String
    var jumlah_produk: Float
    var harga_produk: Int
    var sub_harga: Int
    
    enum CodingKeys: String, CodingKey {
        case id,
             penjualan_id,
             produk_id,
             jumlah_produk,
             harga_produk,
             sub_harga
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        penjualan_id = try values.decode(String.self, forKey: .penjualan_id)
        produk_id = try values.decode(String.self, forKey: .produk_id)
        let jumlahString = try values.decode(String.self, forKey: .jumlah_produk)
        jumlah_produk = Float(jumlahString) ?? 0
        let hargaString = try values.decode(String.self, forKey: .harga_produk)
        harga_produk = Int(hargaString) ?? 0
        let totalString = try values.decode(String.self, forKey: .sub_harga)
        sub_harga = Int(totalString) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(penjualan_id, forKey: .penjualan_id)
        try container.encode(produk_id, forKey: .produk_id)
        try container.encode(jumlah_produk, forKey: .jumlah_produk)
        try container.encode(harga_produk, forKey: .harga_produk)
        try container.encode(sub_harga, forKey: .sub_harga)
    }
}
