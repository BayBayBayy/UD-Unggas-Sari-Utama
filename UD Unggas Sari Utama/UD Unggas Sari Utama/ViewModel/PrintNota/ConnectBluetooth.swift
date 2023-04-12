//
//  ConnectBluetooth.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/04/23.
//

import Foundation
import UIKit
import CoreBluetooth

//class PrinterModel {
//    
//    // Fungsi untuk mencetak nota
//    func cetakNota(penjualan: Penjualan, detailPenjualan: [DetailPenjualan]) {
//        // Buat string untuk mencetak nota
//        var notaString = ""
//        notaString += "Nama Toko\n"
//        notaString += "Alamat Toko\n"
//        notaString += "Kontak Toko\n"
//        notaString += "\n"
//        notaString += "====================\n"
//        notaString += "Nota Penjualan\n"
//        notaString += "Tanggal: \(penjualan.tanggal)\n"
//        notaString += "====================\n"
//        notaString += "ID    Produk             Harga    Jumlah    Subtotal\n"
//        notaString += "---------------------------------------------------\n"
//        for detail in detailPenjualan {
//            notaString += "\(detail.id)    \(detail.produk_id)    \(detail.harga)    \(detail.jumlah)    \(detail.subHarga)\n"
//        }
//        notaString += "---------------------------------------------------\n"
//        notaString += "Total Harga: \(penjualan.totalHarga)\n"
//        
//        // Konversi string ke data
//        guard let notaData = notaString.data(using: .utf8) else {
//            print("Error: Gagal mengubah nota string menjadi data")
//            return
//        }
//        
//        // Cetak nota menggunakan Bluetooth printer
//        let centralManager = CBCentralManager()
//        let printerName = "Nama Printer Bluetooth"
//        var printerPeripheral: CBPeripheral?
//        centralManager.scanForPeripherals(withServices: nil) // Scan printer Bluetooth yang tersedia
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Tunggu 5 detik sampai scanning selesai
//            for peripheral in centralManager.retrievePeripherals(withIdentifiers: []) {
//                if peripheral.name == printerName {
//                    printerPeripheral = peripheral
//                }
//            }
//            guard let printer = printerPeripheral else {
//                print("Error: Printer Bluetooth tidak ditemukan")
//                return
//            }
//            printer.delegate = self
//            centralManager.connect(printer) // Koneksikan printer Bluetooth
//        }
//    }
//}
//
//extension PrinterModel: CBPeripheralDelegate {
//    func isEqual(_ object: Any?) -> Bool {
//        <#code#>
//    }
//    
//    var hash: Int {
//        <#code#>
//    }
//    
//    var superclass: AnyClass? {
//        <#code#>
//    }
//    
//    func `self`() -> Self {
//        <#code#>
//    }
//    
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//    
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//    
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//    
//    func isProxy() -> Bool {
//        <#code#>
//    }
//    
//    func isKind(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//    
//    func isMember(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//    
//    func conforms(to aProtocol: Protocol) -> Bool {
//        <#code#>
//    }
//    
//    func responds(to aSelector: Selector!) -> Bool {
//        <#code#>
//    }
//    
//    var description: String {
//        <#code#>
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        if let error = error {
//            print("Error: Gagal menemukan services printer Bluetooth")
//            return
//        }
//        guard let services = peripheral.services else {
//            print("Error: Services printer Bluetooth tidak ditemukan")
//            return
//        }
//        for service in services {
//            peripheral.discoverCharacteristics(nil, for: service) // Temukan semua characteristic yang tersedia
//        }
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        if let error = error {
//            print("Error: Gagal menemukan characteristic printer Bluetooth")
//            return
//        }
//        guard let characteristics = service.characteristics else {
//            print("Error: Characteristic printer Bluetooth tidak ditemukan")
//            return
//        }
//        for characteristic in characteristics {
//            if characteristic.properties.contains(.write) {
//                peripheral.writeValue(notaData, for: characteristic, type: .withResponse) // Tulis data nota ke characteristic printer Bluetooth
//            }
//        }
//    }
//}
