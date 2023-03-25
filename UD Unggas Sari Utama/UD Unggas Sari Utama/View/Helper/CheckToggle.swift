//
//  CheckToggle.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 16/03/23.
//

import SwiftUI

struct CheckToggle: View {
    @Binding var isOn : Bool
    private let title : String
    
    init(isOn: Binding<Bool>, title: String) {
        self._isOn = isOn
        self.title = title
    }
    
    var body: some View {
        VStack{
            Toggle(title, isOn: $isOn)
                .toggleStyle(SmallRoundedButtonStyle())
        }
    }
}

struct SmallRoundedButtonStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(configuration.isOn ? .green : .secondary)
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
