//
//  ProdukDataResponse.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 15/02/23.
//

import Foundation

struct ProdukResponseModel: Decodable {
    let idProduk: UUID
    let namaProduk: String
    let satuan: String
    let produkKategori: String
    let imageProduk: String
    let jumlahProduk: Int
    let harga: Int
    let tanggalProduk: Date
}

struct modelRespon: Decodable{
    let error: Bool
    let message: String
    let data:[ProdukResponseModel]
}
