//
//  RadioButtonView.swift
//  UD Unggas Sari Utama
//
//  Created by I Wayan Adnyana on 04/02/23.
//

import SwiftUI


//MARK:- Single Radio Button Field
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
    ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

//MARK:- Group of Radio Buttons
enum Status: String {
    case bertambah = "Bertambah"
    case berkurang = "Berkurang"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    @Binding var statusBertambah: Bool
    @Binding var statusBerkurang: Bool
    
    var body: some View {
        HStack {
            radioBertambah
            radioBerkurang
        }
    }
    
    var radioBertambah: some View {
        RadioButtonField(
            id: Status.bertambah.rawValue,
            label:Status.bertambah.rawValue,
            isMarked: selectedId == Status.bertambah.rawValue ? true : false,
            callback: radioGroupCallback
        )
        
    }
    
    var radioBerkurang: some View {
        RadioButtonField(
            id: Status.berkurang.rawValue,
            label: Status.berkurang.rawValue,
            isMarked: selectedId == Status.berkurang.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        if id == Status.bertambah.rawValue {
            statusBertambah = true
            statusBerkurang = false
        } else {
            statusBertambah = false
            statusBerkurang = true
        }
        callback(id)
    }
}
