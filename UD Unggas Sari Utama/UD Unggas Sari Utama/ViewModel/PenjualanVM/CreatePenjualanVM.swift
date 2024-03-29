//
//  CreatePenjualanVM.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 22/03/23.
//

import Foundation
import Combine
import CoreBluetooth
import UIKit

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
        return Int(detailPenjualanList.reduce(0) { $0 + (Float($1.harga) * $1.jumlah) })
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
    func tambahDetailPenjualan(penjualanId: String, produkId: String, jumlah: Float) {
        guard let produk = produkViewModel.produk.first(where: { $0.id == produkId }) else {
            return
        }
        let hargaFloat = Float(produk.harga)
        let subHarga = hargaFloat * jumlah
        let detailPenjualan = DetailPenjualan(id: UUID().uuidString, penjualanId: penjualanId, produk_id: produk.id, jumlah: Float(jumlah), harga: produk.harga, subHarga: Int(subHarga))
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
        let newPenjualan = Penjualan(id: penjualanId, totalHarga: Int(totalHarga), tanggal: Date())
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
        }
        
        if let url = URL(string: "https://2019lulus.site/UD.AmertaYoga/Penjualan/createPenjualan.php") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
   
            let jsonData = try? JSONSerialization.data(withJSONObject: [
                "penjualan": [
                    "penjualan_id": penjualanId,
                    "total_harga": totalHarga,
                    "tanggal_penjualan": tanggal
                ] as [String : Any],
                "detail_penjualan_list": detailPenjualanListToUpload
            ] as [String : Any])
            
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
                        print("produk berhasil ditambahkan")
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func cetakNota() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggal = dateFormatter.string(from: Date())

        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: "")
        
        // header nota
        let tokoImage = UIImage(named: "UD-Amerta-Yoga.png")!
        let tokoImageData = tokoImage.pngData()!
        let tokoBase64 = tokoImageData.base64EncodedString()
        
        let headerHTML = """
        <div style="text-align: center;">
            <img src="data:image/png;base64,\(tokoBase64)" alt="Toko Image" width="200" height="200">
            <h1>UD. Amerta Yoga</h1>
            <p>Br. Demulih, Susut, Bangli</p>
            <p>081</p>
            <hr>
        </div>
        """
        printFormatter.markupText = headerHTML
        
        // detail penjualan
        var detailHTML = "<table style='margin: 50 auto;'>"
        detailHTML += "<tr><th>Nama Produk</th><th>Satuan</th><th>Jumlah</th><th>Harga</th><th>Subtotal</th></tr>"
        for detail in detailPenjualanList {
            if let produk = produkViewModel.produk.first(where: { $0.id == detail.produk_id }) {
                detailHTML += "<tr>"
                detailHTML += "<td>\(produk.nama_produk)</td>"
                detailHTML += "<td>\(produk.satuan)</td>"
                detailHTML += "<td>\(detail.jumlah)</td>"
                detailHTML += "<td>\(produk.harga)</td>"
                detailHTML += "<td>\(detail.subHarga)</td>"
                detailHTML += "</tr>"
            } else {
                // Handle the case where the element is not found or produkList is nil
                print("produk nil")
            }
        }
        detailHTML += "</table>"
        printFormatter.markupText! += detailHTML
        
        // footer nota
        let footerHTML = """
        <div style="text-align: center;">
            <hr>
            <p>Total Harga: \(totalHarga)</p>
            <p>Tanggal: \(tanggal)</p>
        </div>
        """
        printFormatter.markupText! += footerHTML
        
        printController.printFormatter = printFormatter
        
        printController.present(animated: true, completionHandler: nil)
    }


    
    func clearDetailPenjualanList() {
        detailPenjualanList = []
    }
    
    func tambahPemesanan(namaPembeli: String, nohp: String, dp: Int, tanggalAmbil: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggal = dateFormatter.string(from: Date())
        let tanggalAmbilPesan = dateFormatter.string(from: tanggalAmbil)
        
        let sisaPembayaran = Int(totalHarga) - dp
        let status = 0
        let idPesan = UUID().uuidString
        
        let pesanan = Pemesanan(id: idPesan, total_harga: Int(totalHarga), nama_pembeli: namaPembeli, no_hp: nohp, dp_dibayar: dp, sisa_pembayaran: sisaPembayaran, status: status, tanggal_pemesanan: Date(), tanggal_pengambilan: tanggalAmbil)
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
        
        if let url = URL(string: "https://2019lulus.site/UD.AmertaYoga/Pemesanan/createPemesanan.php") {
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
                ] as [String : Any],
                "detail_pemesanan_list": detailPemesananListToUpload
            ] as [String : Any])
            
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
    var no_hp: String
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
    var jumlah: Float
    var harga: Int
    var subHarga: Int
    
}
