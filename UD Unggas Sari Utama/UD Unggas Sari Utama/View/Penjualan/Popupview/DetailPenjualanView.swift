//
//  DetailPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 29/03/23.
//

import SwiftUI
import Combine
import CoreBluetooth
import UIKit

struct DetailPenjualanView: View {
    let penjualan: PenjualanResponseModel
    let dataDetailPenjualan: [DetailPenjualanModel]
    @ObservedObject var dataProduk: ProdukFetcher
    @Binding var close: Bool
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                VStack{
                    Text("Daftar Belanja")
                        .bold()
                        .font(.system(size: 24))
                        .padding(.top)
                    HStack{
                        Text("No")
                            .bold()
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity)
                        Text("Nama")
                            .bold()
                            .font(.system(size: 16))
                            .frame(width: geometry.size.width/5)
                            .frame(maxWidth: .infinity)
                        Text("Jumlah")
                            .bold()
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                        Text("Harga")
                            .bold()
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                        Text("Total")
                            .bold()
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/12)
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/6)
                
                ScrollView(){
                    ForEach(Array(dataDetailPenjualan.enumerated()), id: \.1.id) { index, model in
                           let produk = dataProduk.getProdukById(id: model.produk_id)
                           let nomorUrut = index + 1
                        
                           HStack{
                               Text("\(nomorUrut)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text(produk!.nama_produk)
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%1g", model.jumlah_produk))
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text("\(model.harga_produk)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text("\(model.sub_harga)")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                        }
                        
                        .frame(width: geometry.size.width/1.1, height: geometry.size.height/8)
                        .background(Color("GrayContentColor"))
                        .cornerRadius(10)       
                    }
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2)
                
                VStack{
                    RoundedRectangle(cornerRadius: 0.1)
                        .fill(.black)
                        .frame(width: geometry.size.width/1, height: 2)
                    HStack{
                        Text("Harga Total")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        
                        Text("\(penjualan.total_harga)")
                            .bold()
                            .font(.system(size: 20))
                        
                    }.frame(width: geometry.size.width/1.1, height: geometry.size.height/10)
                    Spacer()
                        .frame(width: geometry.size.width/1.1, height: geometry.size.height/18)
                    
                    HStack{
                        Button{
                            cetakNota()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    . frame( width: geometry.size.width/5, height: geometry.size.height/12)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("Print Nota")
                                    .bold()
                                    .font(.title2)
                            }
                            .frame( width: geometry.size.width/5, height: geometry.size.height/12)
                        }
                        
                        Button{
                            close = false
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    . frame( width: geometry.size.width/8, height: geometry.size.height/12)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("OK")
                                    .bold()
                                    .font(.title)
                            }
                            .frame( width: geometry.size.width/8, height: geometry.size.height/12)
                        }
                    }
                    
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .background(Color("GrayBackgroundColor"))
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    func cetakNota() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: "")
        
        // header nota
        let tokoImage = UIImage(named: "UD-Amerta-Yoga.png")!
        let tokoImageData = tokoImage.pngData()!
        let tokoBase64 = tokoImageData.base64EncodedString()
        
        let headerHTML = """
        <div style="text-align: center;">
            <img src="data:image/png;base64,\(tokoBase64)" alt="Toko Image" width="200" height="200">
            <h1>UD. Amerta Yoga</h1>
            <p>Br. Demulih, Susut, Bangli</p>
            <p>081</p>
            <hr>
        </div>
        """
        printFormatter.markupText = headerHTML
        
        // detail penjualan
        var detailHTML = "<table style='margin: 50 auto;'>"
        detailHTML += "<tr><th>Nama Produk</th><th>Satuan</th><th>Jumlah</th><th>Harga</th><th>Subtotal</th></tr>"
        for detail in dataDetailPenjualan {
            if let produk = dataProduk.produk.first(where: { $0.id == detail.produk_id }) {
                detailHTML += "<tr>"
                detailHTML += "<td>\(produk.nama_produk)</td>"
                detailHTML += "<td>\(produk.satuan)</td>"
                detailHTML += "<td>\(detail.jumlah_produk)</td>"
                detailHTML += "<td>\(produk.harga)</td>"
                detailHTML += "<td>\(detail.sub_harga)</td>"
                detailHTML += "</tr>"
            } else {
                // Handle the case where the element is not found or produkList is nil
                print("produk nil")
            }
        }
        detailHTML += "</table>"
        printFormatter.markupText! += detailHTML
        
        // footer nota
        let footerHTML = """
        <div style="text-align: center;">
            <hr>
            <p>Total Harga: \(penjualan.total_harga)</p>
            <p>Tanggal: \(dateFormatter.string(from: penjualan.tanggal_penjualan))</p>
        </div>
        """
        printFormatter.markupText! += footerHTML
        
        printController.printFormatter = printFormatter
        
        printController.present(animated: true, completionHandler: nil)
    }
}

