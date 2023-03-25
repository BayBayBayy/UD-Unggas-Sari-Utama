//
//  CreatePenjualanVM.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 22/03/23.
//

import Foundation
import Combine

class PenjualanViewModel: ObservableObject {
    @Published var penjualanList = [Penjualan]()
    @Published var detailPenjualanList: [DetailPenjualan] = []
    @Published var reloadList = false
    
    var produkViewModel: ProdukFetcher // ViewModel produk
    var currentDetailCount: Int {
        return detailPenjualanList.count
    }
    var totalHarga: Int {
        return detailPenjualanList.reduce(0) { $0 + ($1.harga * $1.jumlah) }
    }
    private var cancellables = Set<AnyCancellable>()
    
    
    init(produkViewModel: ProdukFetcher) {
        self.produkViewModel = produkViewModel
        $detailPenjualanList.sink { _ in
            self.reloadList = true
        }.store(in: &cancellables)
    }
    
    
    // Menambahkan data penjualan baru
    func tambahPenjualan(totalHarga: Int, tanggal: Date) {
        let penjualan = Penjualan(id: UUID().uuidString, totalHarga: totalHarga, tanggal: tanggal)
        penjualanList.append(penjualan)
    }

    // Menambahkan data detail penjualan
    func tambahDetailPenjualan(penjualanId: String, produkId: String, jumlah: Int) {
        guard let produk = produkViewModel.produk.first(where: { $0.id == produkId }) else {
            return
        }
        let subHarga = produk.harga * jumlah
        let detailPenjualan = DetailPenjualan(id: UUID().uuidString, penjualanId: penjualanId, namaBarang: produk.nama_produk, harga: produk.harga, jumlah: jumlah, subHarga: subHarga)
        detailPenjualanList.append(detailPenjualan)
        reloadList.toggle()
        objectWillChange.send()
        print("ini detail \(detailPenjualan)")
        print("ini datalist \(detailPenjualanList)")
    }
    
    func clearDetailPenjualanList() {
        detailPenjualanList = []
    }
}

// Model penjualan
struct Penjualan: Identifiable {
    var id: String
    var totalHarga: Int
    var tanggal: Date
}

// Model detail penjualan
struct DetailPenjualan: Identifiable {
    var id: String
    var penjualanId: String
    var namaBarang: String
    var harga: Int
    var jumlah: Int
    var subHarga: Int
    
    mutating func updateJumlah(_ newJumlah: Int) {
        jumlah = newJumlah
    }
}
