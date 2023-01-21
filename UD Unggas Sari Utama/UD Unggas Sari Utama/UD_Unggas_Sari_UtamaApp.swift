//
//  UD_Unggas_Sari_UtamaApp.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 28/12/22.
//

import SwiftUI

@main
struct UD_Unggas_Sari_UtamaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
