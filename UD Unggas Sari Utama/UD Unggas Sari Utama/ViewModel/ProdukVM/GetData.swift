//
//  GetData.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/02/23.
//

import Foundation
import Combine

class ProdukFetcher: ObservableObject {
    //    @Published var produk: [ProdukResponseModel] = []
    @Published var produk: [ProdukResponseModel] = []
    @Published var produkEcer = [ProdukResponseModel]()
    @Published var produkStatus = [ProdukResponseModel]()
    @Published var selectedProduk: ProdukResponseModel? // tambahkan properti selectedProduk
    @Published var selectedProduct: ProdukResponseModel?
    @Published var selectedProdukId: String?
    private var cancellable: AnyCancellable?
    var data1 = CurrentValueSubject<String, Never>("Data awal")
    
    init(){
        fetchData()
        fetchDataEcer()
    }
    
    
    // View Data
    func fetchData() {
        
        guard let url = URL(string: "https://indramaryati.com/bayu/Produk/viewProduk.php") else {
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
                    self.data1.send("Data baru")
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    // View Data Ecer
    func fetchDataEcer() {
        guard let url = URL(string: "https://indramaryati.com/bayu/Produk/produkEcer.php") else {
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
                let produkEcer = try JSONDecoder().decode([ProdukResponseModel].self, from: data)
                DispatchQueue.main.async {
                    self.produkEcer = produkEcer
                    self.data1.send("Data baru")
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    // View Data yang terjual
    func fetchStatusProduk() {
        guard let url = URL(string: "https://indramaryati.com/bayu/Produk/produkEcer.php") else {
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
                let produkStatus = try JSONDecoder().decode([ProdukResponseModel].self, from: data)
                DispatchQueue.main.async {
                    self.produkStatus = produkStatus
                    self.data1.send("Data baru")
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func refreshData() {
        self.produk.removeAll()
        self.produkEcer.removeAll()
        fetchData()
        fetchDataEcer()
    }
    
    func getIdFromName(productName: String, viewModel: ProdukFetcher) -> String? {
        if let index = viewModel.produk.firstIndex(where: { $0.nama_produk == productName }) {
            return viewModel.produk[index].id
        } else {
            return nil
        }
    }


    func getProdukById(id: String) -> ProdukResponseModel? {
        return produk.first(where: { $0.id == id })
    }
    
    func selectProdukId(withId id: String) {
        self.selectedProdukId = id
    }
    
    func selectProduct(_ product: ProdukResponseModel) {
        self.selectedProduct = product
    }
    
    func selectProduk(produk: ProdukResponseModel) {
        self.selectedProduk = produk
    }
    
    func resetSelectedProduk() {
        self.selectedProduk = nil
    }   
}

