//
//  LanguageTrivia.swift
//  codecracker
//
//  Created by Gabriel Scholze on 9/1/24.
//

import SwiftUI

struct LanguageTrivia: View {
    var language: Language
    @ObservedObject var lm: LanguageManager = LanguageManager()
    @State var progressBarValue: Double = 0.0
    var body: some View {
        VStack {
            Text(language.name)
                .font(.title)
                .fontWeight(.bold)
            ProgressView("Score", value:progressBarValue,total: 15)
                .padding(.horizontal,64)
            Spacer()
            
        }.onAppear(
            perform: {
                switch language.name {
                case "C++":
                    self.progressBarValue=lm.userScores.cpp
                case "Java":
                    self.progressBarValue=lm.userScores.java
                default:
                    print()
                }
            })
        
    }
}

#Preview {
    LanguageTrivia(language: Language(id: 1, name:"Teste", questions: []),lm:LanguageManager())
}
