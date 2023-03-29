//
//  CreateDataProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

class ProdukManager {
    private let produkManager = ProdukFetcher()
    
    func simpanProduk(id: String, nama_produk: String, satuan: String, produk_kategori: String, harga: String, jumlah_produk: String, produk_ecer: Bool,  tanggal_masuk_produk: Date, completionHandler: @escaping (String?) -> Void) {
        
        let url = URL(string: "https://indramaryati.com/bayu/Produk/createProduk.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var imageName: String {
            switch produk_kategori {
            case "Daging Unggas":
                return "daging-unggas.png"
            case "Bibit Unggas":
                return "bibit-unggas.png"
            case "Pakan Hewan":
                return "pakan-hewan.png"
            case "Obat Hewan":
                return "obat-hewan.png"
            case "Service":
                return "service.png"
            case "Peralatan Unggas":
                return "peralatan-unggas.png"
            case "Lain-lain":
                return "lain-lain.png"
            default:
                return "default.png"
            }
        }
        let status = "1"
        let ecerString = produk_ecer ? "1" : "0"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggalString = dateFormatter.string(from: tanggal_masuk_produk)
        
        let postString = "id=\(id)&nama_produk=\(nama_produk)&satuan=\(satuan)&produk_kategori=\(produk_kategori)&image=\(imageName)&harga=\(harga)&jumlah_produk=\(jumlah_produk)&produk_ecer=\(ecerString)&status_produk=\(status)&tanggal_masuk_produk=\(tanggalString)"
        print("ini hasil \(postString)")
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                if responseString == "Produk berhasil disimpan" {
                    self.produkManager.refreshData()
                }
                completionHandler(responseString)
            }
        }
        
        task.resume()
    }
    
    func editProduk(id: String, namaProduk: String, satuanProduk: String, kategoriProduk: String, hargaProduk: String, jumlahProduk: String, produkEcer: Bool, produkStatus: Bool, tanggalMasukProduk: Date, completionHandler: @escaping (Bool, String) -> Void) {
        
        // URL endpoint untuk edit produk
        let url = URL(string: "https://indramaryati.com/bayu/Produk/updateProduk.php")!
        
        // Buat request dengan metode HTTP POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var imageName: String {
            switch kategoriProduk {
            case "Daging Unggas":
                return "daging-unggas.png"
            case "Bibit Unggas":
                return "bibit-unggas.png"
            case "Pakan Hewan":
                return "pakan-hewan.png"
            case "Obat Hewan":
                return "obat-hewan.png"
            case "Service":
                return "service.png"
            case "Peralatan Unggas":
                return "peralatan-unggas.png"
            case "Lain-lain":
                return "lain-lain.png"
            default:
                return "default.png"
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggalString = dateFormatter.string(from: tanggalMasukProduk)
        
        // Menyiapkan data yang akan dikirim
        let parameters: [String: Any] = [
            "id": id,
            "nama_produk": namaProduk,
            "satuan": satuanProduk,
            "produk_kategori": kategoriProduk,
            "image": imageName,
            "harga": hargaProduk,
            "jumlah_produk": jumlahProduk,
            "produk_ecer": produkEcer ? "1" : "0",
            "produk_ecer": produkStatus ? "1" : "0",
            "tanggal_masuk_produk": tanggalString
        ]
        print("ini paramaternya : \(parameters)")
        do {
            // Encode data menjadi format JSON dan memasukkan ke dalam body request
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            print("ini jsonData: \(jsonData)")
        } catch {
            completionHandler(false, "Terjadi kesalahan saat mengirim data")
            return
        }
        
        // Kirim request ke server menggunakan URLSession
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Handle response dari server
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completionHandler(false, "Terjadi kesalahan saat mengirim data")
                return
            }
            
            if response.statusCode == 200 {
                // Response dari server sukses
                completionHandler(true, "Data produk berhasil diubah")
            } else {
                // Response dari server gagal
                completionHandler(false, "Terjadi kesalahan pada server")
            }
            print(data)
        }
        task.resume()
    }
    
    
}
