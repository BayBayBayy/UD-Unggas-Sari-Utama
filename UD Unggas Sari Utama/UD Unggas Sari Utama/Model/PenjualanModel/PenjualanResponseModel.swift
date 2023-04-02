//
//  PenjualanResponseModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/02/23.
//

import Foundation

struct  PenjualanResponseModel: Codable, Hashable{
    var penjualan_id: String
    var total_harga: Int
    var tanggal_penjualan: Date
    
    
    enum CodingKeys: String, CodingKey {
        case penjualan_id, total_harga, tanggal_penjualan
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        penjualan_id = try values.decode(String.self, forKey: .penjualan_id)
        let hargaString = try values.decode(String.self, forKey: .total_harga)
        total_harga = Int(hargaString) ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tanggal_penjualan = try dateFormatter.date(from: values.decode(String.self, forKey: .tanggal_penjualan)) ?? Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(penjualan_id, forKey: .penjualan_id)
        try container.encode(total_harga, forKey: .total_harga)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(dateFormatter.string(from: tanggal_penjualan), forKey: .tanggal_penjualan)
        
    }
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        hasher.combine(tanggal_pembelian)
//        hasher.combine(total_harga)
//        
//        
//    }
    
}

struct PenjualanPerProdukModel {
    var namaProduk: String
    var jumlahTerjual: Int
}
