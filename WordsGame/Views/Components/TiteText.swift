//
//  TiteText.swift
//  WordsGame
//
//  Created by Денис Александров on 18.10.2022.
//

import SwiftUI

struct TiteText: View {
    
    @State var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvrnirNext-Bold", size: 42))
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
            .background(Color("FirstPlayer"))
            .foregroundColor(.white)
    }
}

struct TiteText_Previews: PreviewProvider {
    static var previews: some View {
        TiteText(text: "Магнитотерапия")
    }
}





