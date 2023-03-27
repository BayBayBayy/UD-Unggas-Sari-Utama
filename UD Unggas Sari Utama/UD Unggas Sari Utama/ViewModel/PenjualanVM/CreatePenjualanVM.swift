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
    @Published var produkList: [ProdukResponseModel] = []
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
        let detailPenjualan = DetailPenjualan(id: UUID().uuidString, penjualanId: penjualanId, namaBarang: produk.nama_produk, jumlah: jumlah, harga: produk.harga, subHarga: subHarga)
        detailPenjualanList.append(detailPenjualan)
        reloadList.toggle()
        objectWillChange.send()
        print("ini detail \(detailPenjualan)")
        print("ini datalist \(detailPenjualanList)")
    }
    
    func checkout() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggal = dateFormatter.string(from: Date())
        
        let penjualanId = UUID().uuidString
        let newPenjualan = Penjualan(id: penjualanId, totalHarga: totalHarga, tanggal: Date())
        penjualanList.append(newPenjualan)
        print(newPenjualan)
        
        var detailPenjualanListToUpload = [[String: Any]]()
        for detailPenjualan in detailPenjualanList {
            let id = UUID().uuidString
            
            let newDetailPenjualan = DetailPenjualan(id: id, penjualanId: penjualanId, namaBarang: detailPenjualan.namaBarang,  jumlah: detailPenjualan.jumlah, harga: detailPenjualan.harga, subHarga: detailPenjualan.subHarga)

            detailPenjualanListToUpload.append([
                "id": newDetailPenjualan.id,
                "penjualan_id": newDetailPenjualan.penjualanId,
                "nama_produk": newDetailPenjualan.namaBarang,
                "jumlah_produk": newDetailPenjualan.jumlah,
                "harga_produk": newDetailPenjualan.harga,
                "sub_harga": newDetailPenjualan.subHarga
            ])
            print(detailPenjualanListToUpload)
            //conect to jumlah stok
//            if let produkIndex = produkList.firstIndex(where: { $0.id == detailPenjualan.produk.id }) {
//                produkList[produkIndex] -= detailPenjualan.jumlah
//            }
        }
        
        if let url = URL(string: "https://indramaryati.com/bayu/Penjualan/createPenjualan.php") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            let jsonData = try? JSONSerialization.data(withJSONObject: [
                "penjualan": [
                    "id": penjualanId,
                    "total_harga": totalHarga,
                    "tanggal": tanggal
                ],
                "detail_penjualan_list": detailPenjualanListToUpload
            ])
            
            print(jsonData)
            
            urlRequest.httpBody = jsonData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Error:", error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    print("Error: No data returned from server")
                    return
                }
                
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response:", responseJSON)
                    DispatchQueue.main.async {
                        self.clearDetailPenjualanList()
                        print("produk berhasil ditambahkan")
                        
                    }
                }
            }
            
            task.resume()
        }
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
    var jumlah: Int
    var harga: Int
    var subHarga: Int
    
    mutating func updateJumlah(_ newJumlah: Int) {
        jumlah = newJumlah
    }
}
