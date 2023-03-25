//
//  ProdukDataResponse.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 15/02/23.
//

import Foundation

struct ProdukResponseModel: Codable, Identifiable, Hashable{
    let id: String
    let nama_produk: String
    let satuan: String
    let produk_kategori: String
    let image: String
    let harga: Int
    let jumlah_produk: Int
    let produk_ecer: Bool
    let tanggal_masuk_produk: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case nama_produk
        case satuan
        case produk_kategori
        case image
        case harga
        case jumlah_produk
        case produkEcer = "produk_ecer"
        case tanggal_masuk_produk
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        nama_produk = try values.decode(String.self, forKey: .nama_produk)
        satuan = try values.decode(String.self, forKey: .satuan)
        produk_kategori = try values.decode(String.self, forKey: .produk_kategori)
        let hargaString = try values.decode(String.self, forKey: .harga)
        harga = Int(hargaString) ?? 0
        image = try values.decode(String.self, forKey: .image)
        let jumlahString = try values.decode(String.self, forKey: .jumlah_produk)
        jumlah_produk = Int(jumlahString) ?? 0
        
        if let produkEcer = try values.decodeIfPresent(String.self, forKey: .produkEcer) {
            self.produk_ecer = produkEcer == "1"
        } else {
            self.produk_ecer = false
        }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tanggal_masuk_produk = try dateFormatter.date(from: values.decode(String.self, forKey: .tanggal_masuk_produk)) ?? Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nama_produk, forKey: .nama_produk)
        try container.encode(satuan, forKey: .satuan)
        try container.encode(produk_kategori, forKey: .produk_kategori)
        try container.encode(image, forKey: .image)
        try container.encode(harga, forKey: .harga)
        try container.encode(jumlah_produk, forKey: .jumlah_produk)
        try container.encode(produk_ecer, forKey: .produkEcer)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(dateFormatter.string(from: tanggal_masuk_produk), forKey: .tanggal_masuk_produk)
        
    }
    
}

//struct modelRespon: Codable{
//    let error: Bool
//    let message: String
//    let data:[ProdukResponseModel]
//}
