//
//  PemesananResponeseModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

struct PemesananResponseModel: Codable, Hashable{
    var pemesanan_id: String
    var total_harga: Int
    var nama_pembeli: String
    var no_hp: String
    var dp_dibayar: Int
    var sisa_pembayaran: Int
    var status: Bool
    var tanggal_pemesanan: Date
    var tanggal_pengambilan: Date
    
    
    enum CodingKeys: String, CodingKey {
        case pemesanan_id,
             total_harga,
             nama_pembeli,
             no_hp,
             dp_dibayar,
             sisa_pembayaran,
             status = "status",
             tanggal_pemesanan,
             tanggal_pengambilan
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pemesanan_id = try values.decode(String.self, forKey: .pemesanan_id)
        let hargaString = try values.decode(String.self, forKey: .total_harga)
        total_harga = Int(hargaString) ?? 0
        nama_pembeli = try values.decode(String.self, forKey: .nama_pembeli)
        no_hp = try values.decode(String.self, forKey: .no_hp)
        let dp = try values.decode(String.self, forKey: .dp_dibayar)
        dp_dibayar = Int(dp) ?? 0
        let sisa = try values.decode(String.self, forKey: .sisa_pembayaran)
        sisa_pembayaran = Int(sisa) ?? 0
        if let produkEcer = try values.decodeIfPresent(String.self, forKey: .status) {
            self.status = produkEcer == "1"
        } else {
            self.status = false
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tanggal_pemesanan = try dateFormatter.date(from: values.decode(String.self, forKey: .tanggal_pemesanan)) ?? Date()
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        tanggal_pengambilan = try date.date(from: values.decode(String.self, forKey: .tanggal_pengambilan)) ?? Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pemesanan_id, forKey: .pemesanan_id)
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
