//
//  LaporanStokVM.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 03/04/23.
//

import Foundation

class LaporanStokFetcher: ObservableObject{
    @Published var produk: [LaporanStokProdukModel] = []
    
    init(){
        fetchData()
    }
    
    // View Data
    func fetchData() {
        
        guard let url = URL(string: "https://indramaryati.com/bayu/Produk/laporanStok.php") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error:", error ?? "Unknown error")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "inf", negativeInfinity: "-inf", nan: "nan")
            do {
                let produk = try JSONDecoder().decode([LaporanStokProdukModel].self, from: data)
                DispatchQueue.main.async {
                    self.produk = produk
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
}
