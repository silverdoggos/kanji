//
//  Hieroglyph.swift
//  kanji
//
//  Created by Artem Shishkin on 11.04.2021.
//

import Foundation

struct Hieroglyph: Decodable, Identifiable {
    private(set) var id = UUID()
    let grade: Int
    let kanji: String
    let meanings: [String]
    let kun_readings: [String]
    let on_readings: [String]
}
