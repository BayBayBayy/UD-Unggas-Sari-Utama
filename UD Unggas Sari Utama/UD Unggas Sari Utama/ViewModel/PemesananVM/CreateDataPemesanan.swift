//
//  CreateDataPemesanan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 27/03/23.
//

import Foundation

class PemesananViewModel: ObservableObject{
    @Published var dataPenjualan = PenjualanViewModel(produkViewModel: ProdukFetcher())
    @Published var dataPemesanan: [Pemesanan] = []
    
    func tambahPemesanan(namaPembeli: String, nohp: Int, dp: Int, tanggalAmbil: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let tanggal = dateFormatter.string(from: Date())
        let tanggalAmbilPesan = dateFormatter.string(from: tanggalAmbil)
        
        let sisaPembayaran = dataPenjualan.totalHarga - dp
        let status = 0
        
        let idPesan = UUID().uuidString
        let pesanan = Pemesanan(id: idPesan, total_harga: dataPenjualan.totalHarga, nama_pembeli: namaPembeli, no_hp: nohp, dp_dibayar: dp, sisa_pembayaran: sisaPembayaran, status: status, tanggal_pemesanan: Date(), tanggal_pengambilan: tanggalAmbil)
        dataPemesanan.append(pesanan)
        print(pesanan)
        
        var detailPemesananListToUpload = [[String: Any]]()
        for detailPenjualan in dataPenjualan.detailPenjualanList {
            let id = UUID().uuidString
            
            let newDetailPenjualan = DetailPenjualan(id: id, penjualanId: idPesan, namaBarang: detailPenjualan.namaBarang,  jumlah: detailPenjualan.jumlah, harga: detailPenjualan.harga, subHarga: detailPenjualan.subHarga)

            detailPemesananListToUpload.append([
                "id": newDetailPenjualan.id,
                "pemesanan_id": newDetailPenjualan.penjualanId,
                "nama_produk": newDetailPenjualan.namaBarang,
                "jumlah_produk": newDetailPenjualan.jumlah,
                "harga_produk": newDetailPenjualan.harga,
                "sub_harga": newDetailPenjualan.subHarga
            ])
            print(detailPemesananListToUpload)
            //conect to jumlah stok
//            if let produkIndex = produkList.firstIndex(where: { $0.id == detailPenjualan.produk.id }) {
//                produkList[produkIndex] -= detailPenjualan.jumlah
//            }
        }
        
        if let url = URL(string: "https://indramaryati.com/bayu/Pemesanan/createPemesanan.php") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            let jsonData = try? JSONSerialization.data(withJSONObject: [
                "pemesanan": [
                    "id": idPesan,
                    "total_harga": dataPenjualan.totalHarga,
                    "nama_pembeli": namaPembeli,
                    "no_hp": nohp,
                    "dp_dibayar": dp,
                    "sisa_pembayaran": sisaPembayaran,
                    "status": status,
                    "tanggal_pemesanan": tanggal,
                    "tanggal_pengambilan": tanggalAmbilPesan
                ],
                "detail_pemesanan_list": detailPemesananListToUpload
            ])
            
            print(jsonData)
            
            urlRequest.httpBody = jsonData
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Error:", error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    print("Error: No data returned from server")
                    return
                }
                
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response:", responseJSON)
                    DispatchQueue.main.async {
                        self.clearPesanan()
                        self.dataPenjualan.clearDetailPenjualanList()
                        print("produk berhasil ditambahkan")
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func clearPesanan(){
        dataPemesanan = []
    }
}

struct Pemesanan: Identifiable {
    var id: String
    var total_harga: Int
    var nama_pembeli: String
    var no_hp: Int
    var dp_dibayar: Int
    var sisa_pembayaran: Int
    var status: Int
    var tanggal_pemesanan: Date
    var tanggal_pengambilan: Date
}
