//
//  DataManager.swift
//  kanji
//
//  Created by Artem Shishkin on 11.04.2021.
//

import Foundation

private enum ParserServiceConstants {
    static let grade = "grade"
    static let kanji = "kanji"
    static let meanings = "meanings"
    static let kun_readings = "kun_readings"
    static let on_readings = "on_readings"
}

class DataManager {
    static let shared = DataManager()
    let decoder = JSONDecoder()
    
    func getData() -> [Hieroglyph] {
        do {
            let path = Bundle.main.path(forResource: "kanjiapi_full", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            
            guard let dictionaries = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return []
            }
            let hieroglyphs = self.getHieroglyphs(from: dictionaries)
            
            return hieroglyphs
        } catch {
            return []
        }
    }
    
    func getHieroglyphs(from dictionaries: [String: Any]) -> [Hieroglyph] {
        let dic = dictionaries["kanjis"] as! [String: [String: Any]]
        
        return dic.values.compactMap { dictionary -> Hieroglyph? in
            guard
                let kanji = dictionary[ParserServiceConstants.kanji] as? String,
                let grade = dictionary[ParserServiceConstants.grade] as? Int,
                let meanings = dictionary[ParserServiceConstants.meanings] as? [String],
                let kun_readings = dictionary[ParserServiceConstants.kun_readings] as? [String],
                let on_readings = dictionary[ParserServiceConstants.on_readings] as? [String]
            else {
                return nil
            }
            
            return Hieroglyph(grade: grade, kanji: kanji, meanings: meanings, kun_readings: kun_readings, on_readings: on_readings)
        }
    }
}
