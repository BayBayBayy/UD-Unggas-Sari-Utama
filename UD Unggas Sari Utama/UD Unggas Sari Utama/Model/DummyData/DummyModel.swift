//
//  DummyModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 26/01/23.
//

import Foundation

struct produkDummy : Hashable {
    var nama : String
    var image : String
    var satuan : String
    var kategori : String

}

extension produkDummy {
    static var itineraryData: [produkDummy] = []
    static var sampleData: [produkDummy] =
    [
        produkDummy (
                      nama: "Ayam Broiller1",
                      image: "AyamBroiller",
                      satuan: "kg",
                      kategori: "Daging Unggas"),
        produkDummy (
                      nama: "Ayam Broiller2",
                      image: "AyamBroiller",
                      satuan: "kg",
                      kategori: "Daging Unggas"),
        produkDummy (
                      nama: "Ayam Broiller3",
                      image: "AyamBroiller",
                      satuan: "kg",
                      kategori: "Daging Unggas"),
        produkDummy (
                      nama: "Ayam Broiller4",
                      image: "AyamBroiller",
                      satuan: "kg",
                      kategori: "Daging Unggas"),
        produkDummy (
                      nama: "Ayam Broiller5",
                      image: "AyamBroiller",
                      satuan: "kg",
                      kategori: "Daging Unggas"),
        produkDummy (
                      nama: "Ayam Broiller6",
                      image: "AyamBroiller",
                      satuan: "kg",
                      kategori: "Daging Unggas")
    ]
}
