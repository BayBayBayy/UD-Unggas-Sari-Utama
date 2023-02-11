//
//  HistoriPenjualanView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 08/02/23.
//

import SwiftUI

struct HistoriPenjualanView: View {
    @State var dummyModel: [Person] = Person.people
    @State private var sortOrder = [KeyPathComparator(\Person.hargaTotal)]

    var body: some View {
        GeometryReader{ geometry in
            VStack{
                Table(Person.people) {
                    TableColumn("No Penjualan", value: \.hargaTotal)
                        TableColumn("Tanggal Penjualan", value: \.tanggal)
                        TableColumn("Detail", value: \.opsi)
                } .frame(width: geometry.size.width/1, height: geometry.size.height/1.5)
                Spacer()
                    .frame(width: geometry.size.width/1, height: geometry.size.height/8)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .navigationTitle("Histori Penjualan")
            .navigationBarTitleDisplayMode(.inline)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct HistoriPenjualanView_Previews: PreviewProvider {
    static var previews: some View {
        HistoriPenjualanView()
    }
}
