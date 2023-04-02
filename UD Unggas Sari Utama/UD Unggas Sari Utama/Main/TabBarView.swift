//
//  TabBarView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 20/01/23.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var produkVM = ProdukFetcher()
    @ObservedObject var penjualanVM = FethcerPenjualan()
    @ObservedObject var pemesananVM = fetchPemesanan()
    init(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(Color("OrangeColorSet"))
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(.black)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.white)]
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some View {
        GeometryReader{ geometry in
            TabView {
                HomeView()
                    .tabItem {
//                        Label("Penjualan", systemImage: "chart.xyaxis.line")
                        Image(systemName: "chart.xyaxis.line").font(.system(size: 40))
                        Text("Penjualan")
                    }
                    .accentColor(.purple)

                PemesananView()
                    .tabItem {
//                        Label("Pesanan", systemImage: "list.bullet.clipboard.fill")
                        Image(systemName: "list.bullet.clipboard.fill").font(.system(size: 40))
                        Text("Pesanan")
                        
                    }
                    .accentColor(.purple)
                StockView()
                    .tabItem {
//                        Label("Stok", systemImage: "shippingbox.fill")
                        VStack{
                            Image(systemName: "shippingbox.fill").font(.system(size: 40))
                            Text("Stok")
                        }
                       
                    }
                    .accentColor(.purple)
            }
            .frame(width: geometry.size.width/1, height: geometry.size.height/1)
            .accentColor(.black)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                UITabBar.appearance().backgroundColor = UIColor(.purple)
                UITabBar.appearance().unselectedItemTintColor = UIColor(.green)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

class ViewRouter: ObservableObject {
    @Published var showTabBar: Bool = true
}

