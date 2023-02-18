//
//  GetData.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/02/23.
//

import Foundation

class ProdukFetcher: ObservableObject {
    @Published var produk: [ProdukResponseModel] = []
    
    init(){
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://indramaryati.com/bayu/service.php") else {
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
                let produk = try JSONDecoder().decode([ProdukResponseModel].self, from: data)
                DispatchQueue.main.async {
                    self.produk = produk
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
}

