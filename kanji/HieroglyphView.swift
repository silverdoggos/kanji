//
//  HieroglyphView.swift
//  kanji
//
//  Created by Artem Shishkin on 08.04.2021.
//

import SwiftUI

struct HieroglyphView: View {
    let text: String
    let color: Color
    let size: CGSize
    
    var body: some View {
        
        ZStack {
            color
            Text(text)
                .font(.title)
        }
        .frame(width: size.height, height: size.width)
        .cornerRadius(size.width / 5)
        .shadow(radius: 5)
    }
}

struct HieroglyphView_Previews: PreviewProvider {
    static var previews: some View {
        HieroglyphView(text: "11", color: .blue, size: CGSize(width: 80, height: 80))
    }
}

