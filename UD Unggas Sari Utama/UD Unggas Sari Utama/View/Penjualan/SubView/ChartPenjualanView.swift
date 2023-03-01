//
//  ChartPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 01/03/23.
//

import SwiftUI

struct ChartPenjualanView: View {
    @ObservedObject var viewModel = FethcerPenjualan()
    let dateFormatter = DateFormatter()
    var data: [(String, Double)] 
    var maxValue: Double {
          data.max { $0.1 < $1.1 }?.1 ?? 0
      }

      var body: some View {
          VStack {
              HStack(alignment: .lastTextBaseline, spacing: 16) {
                  ForEach(data, id: \.0) { date, value in
                      VStack {
                          Text("\(Int(value))")
                              .font(.footnote)
                          Rectangle()
                              .fill(Color.blue)
                              .frame(width: 20, height: CGFloat(value) / CGFloat(maxValue) * 200)
                              .padding(.top, 4)
                          Text(date)
                              .font(.caption)
                      }
                  }
              }
          }
      }
}



