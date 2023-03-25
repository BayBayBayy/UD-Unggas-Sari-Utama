//
//  PemesananResponeseModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

struct PemesananResponseModel: Codable, Identifiable, Hashable{
    var id: String
    var total_harga: Int
    var nama_pembeli: String
    var no_hp: Int
    var dp_dibayar: Int
    var sisa_pembayaran: Int
    var status: Int
    var tanggal_pemesanan: Date
    var tanggal_pengambilan: Date
    
    
    enum CodingKeys: String, CodingKey {
        case id,
             total_harga,
             nama_pembeli,
             no_hp,
             dp_dibayar,
             sisa_pembayaran,
             status,
             tanggal_pemesanan,
             tanggal_pengambilan
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        let hargaString = try values.decode(String.self, forKey: .total_harga)
        total_harga = Int(hargaString) ?? 0
        nama_pembeli = try values.decode(String.self, forKey: .nama_pembeli)
        let noHP = try values.decode(String.self, forKey: .no_hp)
        no_hp = Int(noHP) ?? 0
        let dp = try values.decode(String.self, forKey: .dp_dibayar)
        dp_dibayar = Int(dp) ?? 0
        let sisa = try values.decode(String.self, forKey: .sisa_pembayaran)
        sisa_pembayaran = Int(sisa) ?? 0
        let cek = try values.decode(String.self, forKey: .status)
        status = Int(cek) ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tanggal_pemesanan = try dateFormatter.date(from: values.decode(String.self, forKey: .tanggal_pemesanan)) ?? Date()
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        tanggal_pengambilan = try date.date(from: values.decode(String.self, forKey: .tanggal_pengambilan)) ?? Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(total_harga, forKey: .total_harga)
        try container.encode(nama_pembeli, forKey: .nama_pembeli)
        try container.encode(no_hp, forKey: .no_hp)
        try container.encode(dp_dibayar, forKey: .dp_dibayar)
        try container.encode(sisa_pembayaran, forKey: .sisa_pembayaran)
        try container.encode(status, forKey: .status)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(dateFormatter.string(from: tanggal_pemesanan), forKey: .tanggal_pemesanan)
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        try container.encode(date.string(from: tanggal_pengambilan), forKey: .tanggal_pengambilan)
        
    }
}
