//
//  KanjiView.swift
//  kanji
//
//  Created by Artem Shishkin on 08.04.2021.
//

import SwiftUI

private enum ColoursT {
    static let t1 = Color(red: 0.11, green: 0.61, blue: 0.99)
    static let t2 = Color(red: 0.98, green: 0.50, blue: 0.32)
    static let t3 = Color(red: 0.33, green: 0.90, blue: 0.76)
    static let t4 = Color(red: 0.23, green: 0.23, blue: 0.60)
    static let t5 = Color(red: 0.99, green: 0.45, blue: 0.45)
}

struct KanjiView: View {
    @State var descriptionViewIsNeeded = false
    @State var data: [Hieroglyph] = []
    @State var selectedHieroglyph: Hieroglyph?
    @State var searchingText: String = ""
    @State var searchingData: [Hieroglyph] = []
    
    static let itemSize = 80
    let dataManager = DataManager.shared
    
    var layout = [
        GridItem(.adaptive(minimum: CGFloat(itemSize)))
    ]
    
    var body: some View {
        ZStack{
            let binding = Binding<String>(get: {
                self.searchingText
            }, set: {
                self.searchingText = $0
                if self.searchingText.last == " " {
                    self.searchingText.removeLast()
                }
                searchingData = []
                data.forEach({
                    let lowercassedArray = $0.meanings.map { $0.lowercased() }
                    
                    if lowercassedArray.contains(self.searchingText.lowercased()) {
                        searchingData.append($0)
                    }
                })
            })
            
            VStack(spacing: 20) {
                TextField("search", text: binding)
                    .shadow(radius: 5)
                
                ScrollView {
                    LazyVGrid(columns: layout,  spacing: 20) {
                        ForEach(searchingText.isEmpty ? data : searchingData) { item in
                            HieroglyphView(text: "\(item.kanji)", color: getColor(for: item), size: CGSize(width: KanjiView.itemSize, height: KanjiView.itemSize) )
                                .onTapGesture(count: 1, perform: {
                                    openDiscription()
                                    self.selectedHieroglyph = item
                                })
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                
            }
            .blur(radius: descriptionViewIsNeeded ? 10 : 0)
            
            if descriptionViewIsNeeded, let hieroglyph = selectedHieroglyph {
                DescriptionView(hieroglyph: hieroglyph)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .onAppear() {
            self.data = self.dataManager.getData()
            self.data.sort(by: { one, two in
                return one.grade < two.grade ? true : false
            })
        }
        .onTapGesture {
            descriptionViewIsNeeded = false
            hideKeyboard()
        }
        
    }
    
    private func openDiscription() {
        descriptionViewIsNeeded.toggle()
    }
    
    
    private func getColor(for hieroglyph: Hieroglyph) -> Color {
        switch hieroglyph.grade {
        case 1:
            return ColoursT.t1
        case 2:
            return ColoursT.t2
        case 3:
            return ColoursT.t3
        case 4:
            return ColoursT.t4
        case 5:
            return ColoursT.t5
        default:
            return ColoursT.t5
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct KanjiView_Previews: PreviewProvider {
    static var previews: some View {
        KanjiView()
    }
}
