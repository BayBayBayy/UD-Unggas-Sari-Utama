//
//  TabBarView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 20/01/23.
//

import SwiftUI

struct TabBarView: View {
    init(){
            let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(.yellow)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(.black)
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.white)]
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        
        UITabBar.appearance().backgroundColor = UIColor(Color("colourPurple"))
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("colourLightPurple"))
        }
    var body: some View {
        TabView {
         HomeView()
                .tabItem {
                    Label("Penjualan", systemImage: "keyboard.fill")
                }
                .accentColor(.purple)
            PemesananView()
                .tabItem {
                    Label("Pesanan", systemImage: "list.bullet.clipboard.fill")
                }
                .accentColor(.purple)
            StockView()
                .tabItem {
                    Label("Stok", systemImage: "square.text.square.fill")
                }
                .accentColor(.purple)
        }
        .accentColor(.black)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            UITabBar.appearance().backgroundColor = UIColor(.purple)
            UITabBar.appearance().unselectedItemTintColor = UIColor(.green)
        }
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

