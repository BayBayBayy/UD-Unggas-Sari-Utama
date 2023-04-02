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
    @Published var dataPemesanan: [Pemesanan] = []
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
        let detailPenjualan = DetailPenjualan(id: UUID().uuidString, penjualanId: penjualanId, produk_id: produk.id, jumlah: jumlah, harga: produk.harga, subHarga: subHarga)
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
            
            let newDetailPenjualan = DetailPenjualan(id: id, penjualanId: penjualanId, produk_id: detailPenjualan.produk_id,  jumlah: detailPenjualan.jumlah, harga: detailPenjualan.harga, subHarga: detailPenjualan.subHarga)

            detailPenjualanListToUpload.append([
                "id": newDetailPenjualan.id,
                "penjualan_id": newDetailPenjualan.penjualanId,
                "produk_id": newDetailPenjualan.produk_id,
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
                    "penjualan_id": penjualanId,
                    "total_harga": totalHarga,
                    "tanggal_penjualan": tanggal
                ],
                "detail_penjualan_list": detailPenjualanListToUpload
            ])
            
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
    
    func tambahPemesanan(namaPembeli: String, nohp: Int, dp: Int, tanggalAmbil: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggal = dateFormatter.string(from: Date())
        let tanggalAmbilPesan = dateFormatter.string(from: tanggalAmbil)
        
        let sisaPembayaran = totalHarga - dp
        let status = 0
        let idPesan = UUID().uuidString
        
        let pesanan = Pemesanan(id: idPesan, total_harga: totalHarga, nama_pembeli: namaPembeli, no_hp: nohp, dp_dibayar: dp, sisa_pembayaran: sisaPembayaran, status: status, tanggal_pemesanan: Date(), tanggal_pengambilan: tanggalAmbil)
        dataPemesanan.append(pesanan)
        print(pesanan)
        
        var detailPemesananListToUpload = [[String: Any]]()
        for detailPemesan in detailPenjualanList {
            let id = UUID().uuidString
            
            let newDetailPenjualan = DetailPenjualan(id: id, penjualanId: idPesan, produk_id: detailPemesan.produk_id,  jumlah: detailPemesan.jumlah, harga: detailPemesan.harga, subHarga: detailPemesan.subHarga)

            detailPemesananListToUpload.append([
                "id": newDetailPenjualan.id,
                "pemesanan_id": newDetailPenjualan.penjualanId,
                "produk_id": newDetailPenjualan.produk_id,
                "jumlah_produk": newDetailPenjualan.jumlah,
                "harga_produk": newDetailPenjualan.harga,
                "sub_harga": newDetailPenjualan.subHarga
            ])
            print(detailPemesananListToUpload)
        }
        
        if let url = URL(string: "https://indramaryati.com/bayu/Pemesanan/createPemesanan.php") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            let jsonData = try? JSONSerialization.data(withJSONObject: [
                "pemesanan": [
                    "pemesanan_id": idPesan,
                    "total_harga": totalHarga,
                    "nama_pembeli": namaPembeli,
                    "no_hp": nohp,
                    "dp_dibayar": dp,
                    "sisa_pembayaran": sisaPembayaran,
                    "status": status,
                    "tanggal_pemesanan": tanggal,
                    "tanggal_pengambilan": tanggalAmbilPesan
                ],
                "detail_pemesanan_list": detailPemesananListToUpload
            ])
            
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
                        self.clearPesanan()
                        self.clearDetailPenjualanList()
                        print("produk berhasil ditambahkan")
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func clearPesanan(){
        dataPemesanan = []
    }
}

struct Pemesanan: Identifiable {
    var id: String
    var total_harga: Int
    var nama_pembeli: String
    var no_hp: Int
    var dp_dibayar: Int
    var sisa_pembayaran: Int
    var status: Int
    var tanggal_pemesanan: Date
    var tanggal_pengambilan: Date
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
    var produk_id: String
    var jumlah: Int
    var harga: Int
    var subHarga: Int
    
    mutating func updateJumlah(_ newJumlah: Int) {
        jumlah = newJumlah
    }
}
