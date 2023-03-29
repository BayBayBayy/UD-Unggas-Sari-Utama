//
//  GetData.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 18/02/23.
//

import Foundation

class ProdukFetcher: ObservableObject {
    //    @Published var produk: [ProdukResponseModel] = []
    @Published var produk: [ProdukResponseModel] = []
    @Published var produkEcer = [ProdukResponseModel]()
    @Published var produkStatus = [ProdukResponseModel]()
    @Published var selectedProduk: ProdukResponseModel? // tambahkan properti selectedProduk
    @Published var selectedProduct: ProdukResponseModel?
    @Published var selectedProdukId: String?
    
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
    
    
    func createProduct(completion: @escaping (String) -> Void) {
        let url = URL(string: "http://your-api-url/create_product.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(self.produk)
            request.httpBody = data
        } catch {
            completion("Error: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion("Error: Invalid response")
                return
            }
            
            if response.statusCode == 200 {
                completion("Product created successfully")
            } else {
                completion("Error: \(response.statusCode)")
            }
        }
        
        task.resume()
    }
    
    
}

