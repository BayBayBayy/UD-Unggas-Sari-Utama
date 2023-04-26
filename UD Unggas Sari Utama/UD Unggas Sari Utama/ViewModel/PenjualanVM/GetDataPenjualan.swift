//
//  GetDataPenjualan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 21/02/23.
//

import Foundation

class FethcerPenjualan: ObservableObject{
    @Published var dataPenjualan: [PenjualanResponseModel]  = []
    @Published var selectedPenjualan: PenjualanResponseModel?
    @Published var dataDetail: [DetailPenjualanModel]  = []
    @Published var penjualanPerProdukList: [PenjualanPerProdukModel] = []
    @Published var selectedDetail: DetailPenjualanModel?
    @Published var dataChartProduk: [(String, Double)] = []
    @Published var totalSales = 0
    @Published var totalTransaksi: Int = 0
    @Published var jumlahTransaksi: Int = 0
    @Published var rataTransaksi: Double = 0
    let dateFormatter = DateFormatter()
    private let produkViewModel = ProdukFetcher()
    
    init(){
        fetchData()
        fetchDataDetail()
    }
    
    //penjualan
    func fetchData() {
        guard let url = URL(string: "https://2019lulus.site/UD.AmertaYoga/Penjualan/penjualan.php") else {
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
    
    //detailPenjualan
    func fetchDataDetail() {
        guard let url = URL(string: "https://2019lulus.site/UD.AmertaYoga/Penjualan/detailPenjualan.php") else {
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
                    self.generateChartData(for: Date())
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func generateChartData(for date: Date) {
        var chartData = [String: Double]()
        let selectedDate = Calendar.current.startOfDay(for: date)
        
        for penjualan in dataPenjualan {
            let penjualanDate = Calendar.current.startOfDay(for: penjualan.tanggal_penjualan)
            
            guard selectedDate == penjualanDate else {
                continue
            }
            
            for detail in dataDetail where detail.penjualan_id == penjualan.penjualan_id {
                let jumlahTerjual = Double(detail.jumlah_produk)
                guard let namaProduk = getNamaProduk(for: detail.produk_id) else {
                    continue
                }
                
                let chartKey = "\(namaProduk)"
                
                if let currentTotal = chartData[chartKey] {
                    chartData[chartKey] = currentTotal + jumlahTerjual
                } else {
                    chartData[chartKey] = jumlahTerjual
                }
            }
        }
        dataChartProduk = chartData.map { ($0.key, $0.value) }
    }
    
    func calculatePenjualan(for selectedDate: Date) {
        DispatchQueue.main.async {
            let filteredPenjualan = self.dataPenjualan.filter { Calendar.current.isDate($0.tanggal_penjualan, inSameDayAs: selectedDate) }
            
            self.totalTransaksi = filteredPenjualan.reduce(0, { $0 + $1.total_harga })
            self.jumlahTransaksi = filteredPenjualan.count
            self.rataTransaksi = Double(self.totalTransaksi) / Double(self.jumlahTransaksi)
        }
    }

    func totalTransaksi(for selectedDate: Date) -> Int {
        calculatePenjualan(for: selectedDate)
        return totalTransaksi
    }

    func jumlahTransaksi(for selectedDate: Date) -> Int {
        calculatePenjualan(for: selectedDate)
        return jumlahTransaksi
    }

    func rataTransaksi(for selectedDate: Date) -> Double {
        calculatePenjualan(for: selectedDate)
        return rataTransaksi
    }
    
    
    func getNamaProduk(for id: String) -> String? {
        return produkViewModel.produk.first(where: { $0.id == id })?.nama_produk
    }
    
    func getDetailPenjualan(for id: String) -> DetailPenjualanModel? {
        return dataDetail.first(where: { $0.id == id })
    }
    
    func selectDetail(detail: DetailPenjualanModel) {
        self.selectedDetail = detail
    }
    
    func resetSelectedDetail() {
        self.selectedDetail = nil
    }
    
    func selectPenjualan(penjualan: PenjualanResponseModel) {
        self.selectedPenjualan = penjualan
    }
    
    func resetSelectedPenjualan() {
        self.selectedPenjualan = nil
    }
}
