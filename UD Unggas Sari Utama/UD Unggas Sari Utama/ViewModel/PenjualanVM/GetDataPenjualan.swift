//
//  GetDataPenjualan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/02/23.
//

import Foundation

class FethcerPenjualan: ObservableObject{
    @Published var dataPenjualan = [PenjualanResponseModel]()
    @Published var selectedPenjualan: PenjualanResponseModel?
    
    init(){
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://indramaryati.com/bayu/penjualan.php") else {
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
                let penjualan = try JSONDecoder().decode([PenjualanResponseModel].self, from: data)
                DispatchQueue.main.async {
                    self.dataPenjualan = penjualan
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func selectPenjualan(penjualan: PenjualanResponseModel) {
        self.selectedPenjualan = penjualan
    }
    
    func resetSelectedPenjualan() {
        self.selectedPenjualan = nil
    }
    
}
