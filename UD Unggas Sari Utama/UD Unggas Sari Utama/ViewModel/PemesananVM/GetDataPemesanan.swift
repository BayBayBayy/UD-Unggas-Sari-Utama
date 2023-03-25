//
//  GetDataPemesanan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

class fetchPemesanan: ObservableObject{
    @Published var dataPemesanan = [PemesananResponseModel]()
    @Published var pesananChart: [(String, Double)] = []
    
    init(){
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://indramaryati.com/bayu/Pemesanan/pemesanan.php") else {
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
                let pemesanan = try JSONDecoder().decode([PemesananResponseModel].self, from: data)
                DispatchQueue.main.async {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    self.dataPemesanan = pemesanan
                    self.pesananChart = pemesanan.map { (formatter.string(from: $0.tanggal_pemesanan), Double($0.total_harga)) }
                    self.objectWillChange.send()
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
}
