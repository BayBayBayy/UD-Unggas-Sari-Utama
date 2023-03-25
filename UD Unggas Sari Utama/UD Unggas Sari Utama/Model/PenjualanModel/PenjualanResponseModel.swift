//
//  PenjualanResponseModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/02/23.
//

import Foundation

struct  PenjualanResponseModel: Codable, Identifiable, Hashable{
    var id: String
    var total_harga: Int
    var tanggal_pembelian: Date
    
    
    enum CodingKeys: String, CodingKey {
        case id, total_harga, tanggal_pembelian
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        let hargaString = try values.decode(String.self, forKey: .total_harga)
        total_harga = Int(hargaString) ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tanggal_pembelian = try dateFormatter.date(from: values.decode(String.self, forKey: .tanggal_pembelian)) ?? Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(total_harga, forKey: .total_harga)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(dateFormatter.string(from: tanggal_pembelian), forKey: .tanggal_pembelian)
        
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(tanggal_pembelian)
        hasher.combine(total_harga)
        
        
    }
    
}

