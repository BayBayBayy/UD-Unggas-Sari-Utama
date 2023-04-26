//
//  GetDataPemesanan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 07/03/23.
//

import Foundation

class FetchPemesanan: ObservableObject{
    @Published var dataPemesanan: [PemesananResponseModel] = []
    @Published var selectedPemesanan: PemesananResponseModel?
    @Published var detailPemesanan: [DetailPemesananModel]  = []
    @Published var selectedDetailPemesanan: DetailPemesananModel?
    @Published var selectedProduk: ProdukResponseModel?
    @Published var pesananChart: [(String, Double)] = []
    @Published var dataChartProduk: [(String, Double)] = []
    @Published var totalSales = 0
    @Published var namaProdukLaris: String = ""
    @Published var totalTransaksi: Int = 0
    @Published var jumlahTransaksi: Int = 0
    @Published var rataTransaksi: Double = 0
    @Published var sisaProduk: [Int: Int] = [:]
    private let produkViewModel = ProdukFetcher()
    
    init(){
        fetchData()
        fetchDataDetail()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://2019lulus.site/UD.AmertaYoga/Pemesanan/pemesanan.php") else {
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
                    self.dataPemesanan = pemesanan
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func fetchDataDetail() {
        guard let url = URL(string: "https://2019lulus.site/UD.AmertaYoga/Pemesanan/detailPemesanan.php") else {
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
                let detail = try JSONDecoder().decode([DetailPemesananModel].self, from: data)
                DispatchQueue.main.async {
                    self.detailPemesanan = detail
                    self.generateChartData(for: Date())
                }
            } catch let error {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func getDetailPemesananHariIni() -> [DetailPemesananModel] {
        let currentDate = Date() // tanggal hari ini
        let filteredPemesanan = dataPemesanan.filter { $0.tanggal_pengambilan == currentDate && $0.status == false }
        print("ini filter \(filteredPemesanan)")
        let detailPemesananToday = filteredPemesanan.reduce(into: [DetailPemesananModel]()) { result, pemesanan in
            let filteredDetailPemesanan = detailPemesanan.filter { $0.pemesanan_id == pemesanan.pemesanan_id }
            print("INI DETAIL \(filteredDetailPemesanan)")
            for detailPemesanan in filteredDetailPemesanan {
                if let index = result.firstIndex(where: { $0.produk_id == detailPemesanan.produk_id }) {
                    result[index].jumlah_produk += detailPemesanan.jumlah_produk
                } else {
                    result.append(detailPemesanan)
                }
            }
        }
        
        return detailPemesananToday
    }
    
    func generateChartData(for date: Date) {
        var chartData = [String: Double]()
        let selectedDate = Calendar.current.startOfDay(for: date)
        
        for pemesanan in dataPemesanan {
            let penjualanDate = Calendar.current.startOfDay(for: pemesanan.tanggal_pemesanan)
            
            guard selectedDate == penjualanDate else {
                continue
            }
            
            for detail in detailPemesanan where detail.pemesanan_id == pemesanan.pemesanan_id {
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
    
    func calculatePemesanan(for selectedDate: Date) {
        DispatchQueue.main.async {
            // Filter dataPenjualan dengan selectedDate
            let filteredPenjualan = self.dataPemesanan.filter { Calendar.current.isDate($0.tanggal_pemesanan, inSameDayAs: selectedDate) }
            
            // Dapatkan semua id dari dataPenjualan pada tanggal tersebut
            let penjualanIDs = filteredPenjualan.map { $0.pemesanan_id }
            
            // Filter dataDetailPenjualan dengan penjualanIDs
            let filteredDetailPenjualan = self.detailPemesanan.filter { penjualanIDs.contains($0.pemesanan_id) }
            
            // Hitung jumlah penjualan untuk setiap produk pada filteredDetailPenjualan
            var penjualanPerProduk = [String: Int]()
            for penjualan in filteredDetailPenjualan {
                if let jumlah = penjualanPerProduk[penjualan.produk_id] {
                    penjualanPerProduk[penjualan.produk_id] = jumlah + Int(penjualan.jumlah_produk)
                } else {
                    penjualanPerProduk[penjualan.produk_id] = Int(penjualan.jumlah_produk)
                }
            }
            
            // Dapatkan nama_produk dari produk yang paling banyak terjual pada tanggal tersebut
            let sortedPenjualan = penjualanPerProduk.sorted { $0.value > $1.value }
            if let idProduk = sortedPenjualan.first?.key, let produk = self.produkViewModel.produk.first(where: { $0.id == idProduk }) {
                self.namaProdukLaris = produk.nama_produk
            } else {
                self.namaProdukLaris = ""
            }
            
            // Hitung totalTransaksi, jumlahTransaksi, dan rataTransaksi
            self.totalTransaksi = filteredPenjualan.reduce(0, { $0 + $1.total_harga })
            self.jumlahTransaksi = filteredPenjualan.count
            self.rataTransaksi = Double(self.totalTransaksi) / Double(self.jumlahTransaksi)
        }
    }
    
    func namaProdukLaris(for selectedDate: Date) -> String {
        calculatePemesanan(for: selectedDate)
        return namaProdukLaris
    }
    
    func totalTransaksi(for selectedDate: Date) -> Int {
        calculatePemesanan(for: selectedDate)
        return totalTransaksi
    }
    
    func jumlahTransaksi(for selectedDate: Date) -> Int {
        calculatePemesanan(for: selectedDate)
        return jumlahTransaksi
    }
    
    func rataTransaksi(for selectedDate: Date) -> Double {
        calculatePemesanan(for: selectedDate)
        return rataTransaksi
    }
    
    func getNamaProduk(for id: String) -> String? {
        return produkViewModel.produk.first(where: { $0.id == id })?.nama_produk
    }
    
    func selectProduct(_ product: ProdukResponseModel) {
        self.selectedProduk = product
    }
    
    func selectPemesanan(_ pemesanan: PemesananResponseModel) {
        self.selectedPemesanan = pemesanan
    }
}
