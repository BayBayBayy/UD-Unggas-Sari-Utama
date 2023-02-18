//
//  ProdukViewModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 16/02/23.
//

import Foundation
import SwiftUI


class produkViewModel: ObservableObject{
    @Published var items = [ProdukResponseModel]()
    let prefixURL = "https://indramaryati.com/bayu/service.php"
    
//    init(){
//        fetchData()
//    }
    
//    func fetchData(){
//        guard let url = URL(string: "\(prefixURL)")else{
//            print("not found url")
//            return
//        }
//        URLSession.shared.dataTask(with: url){ (data, res, error) in
//            if error != nil{
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//            do{
//                if let data = data{
//                    let result = try JSONDecoder().decode(modelRespon.self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = result.data
//                    }
//                } else{
//                    print("no data")
//                }
//            } catch let jsonError {
//                print("fetch json error", jsonError.localizedDescription )
//            }
//        }.resume()
//    }
}
