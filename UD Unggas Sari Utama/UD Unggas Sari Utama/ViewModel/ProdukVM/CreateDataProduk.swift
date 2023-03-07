//
//  CreateDataProduk.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

//class ProductRepository {
//
//    func createProduct(product: Product, completion: @escaping (Product?, Error?) -> Void) {
//        guard let url = URL(string: "https://example.com/create_product.php") else {
//            fatalError("Invalid URL")
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(product)
//            request.httpBody = data
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    completion(nil, error)
//                    return
//                }
//                guard let data = data else {
//                    completion(nil, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data returned"]))
//                    return
//                }
//                let decoder = JSONDecoder()
//                do {
//                    let product = try decoder.decode(Product.self, from: data)
//                    completion(product, nil)
//                } catch {
//                    completion(nil, error)
//                }
//            }
//            task.resume()
//        } catch {
//            completion(nil, error)
//        }
//    }
//
//}
