//
//  CreateDataPemesanan.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 27/03/23.
//

import Foundation
import SwiftUI

class PemesananViewModel: ObservableObject{
    @Published var dataPemesanan1: [Pemesanan] = []
    
    init(penjualanViewModel: PenjualanViewModel) {
        self.penjualanViewModel = penjualanViewModel
    }
    
    @ObservedObject var penjualanViewModel: PenjualanViewModel
    
}
