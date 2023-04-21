//
//  DetailPesananPopupview.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct DetailPesananPopupview: View {
    @EnvironmentObject var viewModel : PemesananViewModel
    @ObservedObject var dataProduk: ProdukFetcher
    @Binding var close: Bool
    @State private var isAlertShown = false
    let dateFormatter = DateFormatter()
    let pemesanan: PemesananResponseModel
    let dataDetailPemesnan: [DetailPemesananModel]
    
    var formattedDatePengambilan: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: pemesanan.tanggal_pengambilan)
        
    }
    var formattedDatePemesanan: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: pemesanan.tanggal_pemesanan)
        
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("GrayMiddleColor"))
                    .frame(width: geometry.size.width/1.75, height: geometry.size.height/1.2)
                    .border(Color(.black))
                VStack (alignment: .center, spacing: .zero) {
                    title
                        .frame(maxWidth: .infinity)
                    Spacer()
                        .frame( height: geometry.size.height/12)
                    VStack{
                        HStack{
                            Text("No Pesanan :")
                            
                            Text(pemesanan.pemesanan_id)
                                .bold()
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                        }.frame(maxHeight: .infinity)
                        HStack{
                            Text("Nama :")
                            
                            Text(pemesanan.nama_pembeli)
                                .bold()
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                        }.frame(maxHeight: .infinity)
                        HStack{
                            Text("No HP :")
                            
                            Text(pemesanan.no_hp)
                                .bold()
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                        }.frame(maxHeight: .infinity)
                        HStack{
                            Text("Tanggal pemesanan :")
                            
                            Text(formattedDatePemesanan)
                                .bold()
                            Spacer()
                                .frame(maxWidth: .infinity)
                            
                        }.frame(maxHeight: .infinity)
                        HStack{
                            Text("Tanggal diambil :")
                            
                            Text(formattedDatePengambilan)
                                .bold()
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                            
                        }.frame(maxHeight: .infinity)
                    }.frame( height: geometry.size.height/12)
                    
                    Spacer()
                        .frame( height: geometry.size.height/12)
                    
                    VStack{
                        HStack{
                            Text("No")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text("Nama")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text("Jumlah")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text("Harga")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                            Text("Total")
                                .bold()
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                        }.frame(height: geometry.size.height/20)
                        
                        ScrollView{
                            ForEach(Array(dataDetailPemesnan.enumerated()), id: \.1.id) { index, model in
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
                            }
                            
                        }
                    }
                    .frame(height: geometry.size.height/4)
                    
                    
                    RoundedRectangle(cornerRadius: 0.1)
                        .fill(.black)
                        .frame(width: geometry.size.width/1.75, height: 2)
                    
                    Spacer()
                    
                    VStack{
                        HStack{
                            Text("Harga Total")
                                .bold()
                                .font(.system(size: 18))
                            Spacer()
                            Text("\(pemesanan.total_harga)")
                                .bold()
                                .font(.system(size: 18))
                        }.frame(maxHeight: .infinity)
                        
                        HStack{
                            Text("DP Dibayar")
                                .bold()
                                .font(.system(size: 18))
                            Spacer()
                            Text("\(pemesanan.dp_dibayar)")
                                .bold()
                                .font(.system(size: 18))
                        }.frame(maxHeight: .infinity)
                        
                        HStack{
                            Text("Sisa Pembayaran")
                                .bold()
                                .font(.system(size: 18))
                            Spacer()
                            Text("\(pemesanan.sisa_pembayaran)")
                                .bold()
                                .font(.system(size: 18))
                            
                        }.frame(maxHeight: .infinity)
                    }
                    
                    Spacer()
                    HStack{
                        Button{
                            self.close.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    . frame( width: geometry.size.width/10, height: geometry.size.height/16)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("Kembali")
                                    .bold()
                            }
                        }
                        Button{
                            for model in dataDetailPemesnan {
                                if let produk = dataProduk.getProdukById(id: model.produk_id), model.jumlah_produk > produk.jumlah_produk {
                                    isAlertShown = true
                                    break
                                } else{
                                    let status = "1"
                                    viewModel.pesananSelesai(id: pemesanan.pemesanan_id, status: status ){ success, message in
                                        if success {
                                            // Jika sukses, menampilkan pesan sukses dan menutup tampilan edit produk
                                            print(message)
                                            close = false
                                        } else {
                                            // Jika gagal, menampilkan pesan error
                                            print(message)
                                        }
                                    }
                                }
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("GrayMiddleColor"))
                                    . frame( width: geometry.size.width/10, height: geometry.size.height/16)
                                    .cornerRadius(8)
                                    .border(Color.black, width: 2)
                                Text("Selesai")
                                    .bold()
                            }
                        }
                    }
                }.frame( width: geometry.size.width/2, height: geometry.size.height/1.3)
                
            }.onAppear(){
                dateFormatter.dateFormat = "dd-MM-yyyy" // format tanggal dari data
            }
            .alert(isPresented: $isAlertShown) {
                Alert(title: Text("Peringatan"), message: Text("Jumlah yang dibeli melebihi stok yang ada!"), dismissButton: .default(Text("OK")))
            }
            .frame( width: geometry.size.width/1, height: geometry.size.height/1)
            Spacer()
                .frame( width: geometry.size.width/1, height: geometry.size.height/14)
        }.edgesIgnoringSafeArea(.all)
        
    }
}

extension DetailPesananPopupview{
    var title : some View{
        Text("Pesanan")
            .bold()
            .font(.system(size: 40))
    }
    
}
