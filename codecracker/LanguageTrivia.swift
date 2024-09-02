//
//  LanguageTrivia.swift
//  codecracker
//
//  Created by user264588 on 9/1/24.
//

import SwiftUI

struct LanguageTrivia: View {
    var language: Language
    var body: some View {
        VStack {
            Text(language.name)
                .font(.title)
                .fontWeight(.bold)
            ProgressView("Score", value: 0,total: 100)
                .padding(.horizontal,64)
            Spacer()
            
        }
    }
}

#Preview {
    LanguageTrivia(language: Language(id: 1, name:"Teste", questions: []))
}
