//
//  CreateDataPemesanan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 27/03/23.
//

import Foundation
import SwiftUI

class PemesananViewModel: ObservableObject{
    @Published var dataPemesanan1: [Pemesanan] = []
    
    init(penjualanViewModel: PenjualanViewModel) {
        self.penjualanViewModel = penjualanViewModel
    }
    
    @ObservedObject var penjualanViewModel: PenjualanViewModel
    
    func pesananSelesai(id: String, status: String, completionHandler: @escaping (Bool, String) -> Void) {
        // URL endpoint untuk edit produk
        let url = URL(string: "https://indramaryati.com/bayu/Pemesanan/updateStatusPesanan.php")!
            
        // Buat request dengan metode HTTP POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
            
        // Menyiapkan data yang akan dikirim
        let parameters = "pemesanan_id=\(id)&status=\(status)"
            
        print("ini paramaternya : \(parameters)")
        
        // Set data pada body request
        request.httpBody = parameters.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
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
