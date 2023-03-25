//
//  CreateDataProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

class ProdukManager {
    private let produkManager = ProdukFetcher()
    
    func simpanProduk(id: String, nama_produk: String, satuan: String, produk_kategori: String, image: String, harga: String, jumlah_produk: String, produk_ecer: Bool,  tanggal_masuk_produk: Date, completionHandler: @escaping (String?) -> Void) {
        
        let url = URL(string: "https://indramaryati.com/bayu/Produk/createProduk.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let ecerString = produk_ecer ? "1" : "0"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggalString = dateFormatter.string(from: tanggal_masuk_produk)
        
        let postString = "id=\(id)&nama_produk=\(nama_produk)&satuan=\(satuan)&produk_kategori=\(produk_kategori)&image=\(image)&harga=\(harga)&jumlah_produk=\(jumlah_produk)&produk_ecer=\(ecerString)&tanggal_masuk_produk=\(tanggalString)"
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
    
    func editProduk(id: String, namaProduk: String, satuanProduk: String, kategoriProduk: String, imageProduk: String, hargaProduk: String, jumlahProduk: String, produkEcer: Bool, tanggalMasukProduk: Date, completionHandler: @escaping (Bool, String) -> Void) {
        
        // URL endpoint untuk edit produk
        let url = URL(string: "https://indramaryati.com/bayu/Produk/updateProduk.php")!
        
        // Buat request dengan metode HTTP POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggalString = dateFormatter.string(from: tanggalMasukProduk)
        
        // Menyiapkan data yang akan dikirim
        let parameters: [String: Any] = [
            "id": id,
            "nama_produk": namaProduk,
            "satuan": satuanProduk,
            "produk_kategori": kategoriProduk,
            "image": imageProduk,
            "harga": hargaProduk,
            "jumlah_produk": jumlahProduk,
            "produk_ecer": produkEcer ? "1" : "0",
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
