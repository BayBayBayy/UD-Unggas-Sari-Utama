//
//  ChartPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 01/03/23.
//

import SwiftUI

struct ChartPenjualanView: View {
    let data: [(String, Double)]
    let selectedDate: Date
    let dateFormatter = DateFormatter()

    var body: some View {
        VStack {
            Text("Grafik Penjualan")
                .font(.title)
                .foregroundColor(.black)
            if data.isEmpty {
                Text("Data kosong")
            } else {
                let maxValue = data.max { $0.1 < $1.1 }?.1 ?? 0
                HStack(alignment: .lastTextBaseline, spacing: 16) {
                    ForEach(data.indices, id: \.self) { index in
                        let value = data[index].1
                        let label = data[index].0
                        VStack {
                            Text("\(Int(value))")
                                .font(.footnote)
                            Rectangle()
                                .fill(Color.pink)
                                .frame(width: 20, height: CGFloat(value) / CGFloat(maxValue) * 200)
                                .padding(.top, 4)
                            Text(label)
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
    }
}
