//
//  LaporanStokProdukModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 03/04/23.
//

import Foundation

struct LaporanStokProdukModel: Codable, Hashable{
    var produk_id: String
    var nama_produk: String
    var produk_kategori: String
    var satuan: String
    var harga: Int
    var total_stok: Int
    var stok_terjual: Int
    var stok_selisih: Int
    var stok_sisa: Int
    var tanggal_barang_masuk: Date
    
    enum CodingKeys: String, CodingKey {
        case produk_id
        case nama_produk
        case produk_kategori
        case satuan
        case harga
        case total_stok
        case stok_terjual
        case stok_selisih
        case stok_sisa
        case tanggal_barang_masuk
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        produk_id = try values.decode(String.self, forKey: .produk_id)
        nama_produk = try values.decode(String.self, forKey: .nama_produk)
        produk_kategori = try values.decode(String.self, forKey: .produk_kategori)
        satuan = try values.decode(String.self, forKey: .satuan)
        let hargaString = try values.decode(String.self, forKey: .harga)
        harga = Int(hargaString) ?? 0
        let jumlahString = try values.decode(String.self, forKey: .total_stok)
        total_stok = Int(jumlahString) ?? 0
        let jumlahTerjual = try values.decode(String.self, forKey: .stok_terjual)
        stok_terjual = Int(jumlahTerjual) ?? 0
        let jumlahSelisih = try values.decode(String.self, forKey: .stok_selisih)
        stok_selisih = Int(jumlahSelisih) ?? 0
        let jumlahSisa = try values.decode(String.self, forKey: .stok_sisa)
        stok_sisa = Int(jumlahSisa) ?? 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tanggal_barang_masuk = try dateFormatter.date(from: values.decode(String.self, forKey: .tanggal_barang_masuk)) ?? Date()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(produk_id, forKey: .produk_id)
        try container.encode(nama_produk, forKey: .nama_produk)
        try container.encode(produk_kategori, forKey: .produk_kategori)
        try container.encode(satuan, forKey: .satuan)
        try container.encode(harga, forKey: .harga)
        try container.encode(total_stok, forKey: .total_stok)
        try container.encode(stok_terjual, forKey: .stok_terjual)
        try container.encode(stok_selisih, forKey: .stok_selisih)
        try container.encode(stok_sisa, forKey: .stok_sisa)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(dateFormatter.string(from: tanggal_barang_masuk), forKey: .tanggal_barang_masuk)
        
    }
    
}
