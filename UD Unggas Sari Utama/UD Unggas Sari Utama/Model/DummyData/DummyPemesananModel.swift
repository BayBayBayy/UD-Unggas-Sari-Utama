//
//  DummyPemesananModel.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 09/02/23.
//

import Foundation
import SwiftUI

struct Person: Identifiable {
    let hargaTotal: String
    let tanggal: String
    let opsi: String
    let id = UUID()
}

extension Person{
    static var people: [Person] = [
        Person(hargaTotal: "19000", tanggal: "19122022", opsi: "ButtonPemesananView()")

    ]
}

