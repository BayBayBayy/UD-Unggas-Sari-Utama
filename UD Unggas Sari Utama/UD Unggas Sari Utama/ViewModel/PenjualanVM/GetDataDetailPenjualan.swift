//
//  GetDataDetailPenjualan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 29/03/23.
//

import Foundation

class FetcherDetailPenjualan: ObservableObject{
    @Published var dataDetail = [DetailPenjualanModel]()
    @Published var selectedDetail: DetailPenjualanModel?
    
    init(){
        self.fetchDataDetail()
    }
    
    func fetchDataDetail() {
        guard let url = URL(string: "https://indramaryati.com/bayu/Penjualan/detailPenjualan.php") else {
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
                let detail = try JSONDecoder().decode([DetailPenjualanModel].self, from: data)
                DispatchQueue.main.async {
                    self.dataDetail = detail
                    self.objectWillChange.send()
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func selectDetail(detail: DetailPenjualanModel) {
        self.selectedDetail = detail
    }
    
    func resetSelectedPenjualan() {
        self.selectedDetail = nil
    }
}
