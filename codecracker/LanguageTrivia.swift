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
    @State var progressBarValue: Double = 1.0
    var filteredList : [Question] {
      language.questions.filter {$0.id == Int(progressBarValue)}
    }
    var body: some View {
        VStack {
            Text(language.name)
                .font(.title)
                .fontWeight(.bold)
            ProgressView("Score", value:progressBarValue,total: 15)
                .padding(.horizontal,64)
            Spacer()
            ForEach(filteredList) { q in
                VStack {
                    Text(q.question)
                    ForEach(q.options, id: \.self) { opt in
                        Text(opt.option)
                            
                        
                        
                    }
                }
            }
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
                print(filteredList)
                
            }
            
        )
        
    }
}

#Preview {
    LanguageTrivia(language: Language(id: 1, name:"Teste", questions: [Question(id: 1, question: "What is a string", options: [Option(answer: true, option: "Text")])]),lm:LanguageManager())
}
