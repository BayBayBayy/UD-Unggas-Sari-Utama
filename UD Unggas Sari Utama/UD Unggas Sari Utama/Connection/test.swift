//
//  test.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 06/04/23.
//

import SwiftUI

struct test: View {
    @State private var floatValue: Float = 0.0
    let formatter = NumberFormatter()
    
    var body: some View {
        VStack {
            Text("Float Value: \(floatValue)")
            TextField("Enter a float value", value: Binding<Float>(
                get: { self.floatValue },
                set: { self.floatValue = $0 }
            ), formatter: formatter)
        }
    }
    
    init() {
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    }
}
