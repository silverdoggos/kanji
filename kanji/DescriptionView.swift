//
//  DescriptionView.swift
//  kanji
//
//  Created by Artem Shishkin on 11.04.2021.
//

import SwiftUI
import AVKit

struct DescriptionView: View {
    let hieroglyph: Hieroglyph
//    private let player = AVPlayer(url:  Bundle.main.url(forResource: "video", withExtension: "mov")!)
    
    var body: some View {
        ZStack() {
            Color(red: 0.79, green: 0.83, blue: 0.78)
            
//            VStack() {
//                Spacer()
//                VideoPlayer(player: player)
//                    .frame(width: UIScreen.main.bounds.height * 0.4, height: UIScreen.main.bounds.height * 0.4)
//                    .cornerRadius(UIScreen.main.bounds.height * 0.4 / 10)
//                    .onAppear() {
//                        player.play()
//                    }
                    
                ScrollView {
                    Text(hieroglyph.kanji)
                        .font(.system(size: 100))
                    .foregroundColor(Color(red: 0.99, green: 0.45, blue: 0.45))
                    Text("meanings: \(hieroglyph.meanings.joined(separator: ", ")) \n")
                        .font(.body)
                    Text("kun readings: \(hieroglyph.kun_readings.joined(separator: ", ")) \n")
                        .font(.body)
                    Text("on readings: \(hieroglyph.on_readings.joined(separator: ", ")) \n")
                        .font(.body)
                    Text("grade: \(hieroglyph.grade) \n")
                        .font(.body)
                }
//            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8)
        .cornerRadius(UIScreen.main.bounds.width * 0.8 / 10)
        .shadow(radius: 5)
    }
}



