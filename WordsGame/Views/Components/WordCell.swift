//
//  WordCell.swift
//  WordsGame
//
//  Created by Денис Александров on 20.10.2022.
//

import SwiftUI

struct WordCell: View {
    // это ечейки для таблицы
    
    let word: String
    
    var body: some View {
        
        HStack {
            Text(word)
                .foregroundColor(.white)
                .listRowSeparator(.hidden)
            // alignment выравнивание
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.custom("AvrnirNext-Bold", size: 22))
            
            Text("\(word.count)")
                .padding()
                .font(.custom("AvrnirNext-Bold", size: 22))
                .foregroundColor(.white)
        }
        
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "Магнит")
    }
}
