//
//  LanguageTrivia.swift
//  codecracker
//
//  Created by Gabriel Scholze on 9/1/24.
//

import SwiftUI

struct LanguageTrivia: View {
    var language: Language
    var userScores: UserScores
    @State var progressBarValue: Double = 1.0
    var filteredList : [Question] {
        let questionsArray=language.questions?.allObjects as! [Question]
        return questionsArray.filter {$0.id >= Int32(Int(progressBarValue))}
    }
    var body: some View {
        VStack {
            Text(language.name!)
                .font(.title)
                .fontWeight(.bold)
            ProgressView("Score", value:progressBarValue,total: 15)
                .padding(.horizontal,64)
            Spacer()
            ForEach(filteredList) { (q: Question) in
                VStack {
                    Text(q.question!)
                        .padding()
                    ForEach(q.options!.allObjects as! [Option], id: \.self) { opt in
                        Button(action: {
                            if (opt.answer){
                                
                            }
                        }){                          Text(opt.option!)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.indigo)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }.padding(.horizontal)

                        
                        
                        
                        
                    }
                }
            }
            Spacer()
        }.onAppear(
            perform: {
                switch language.name {
                case "C":
                    self.progressBarValue=Double(userScores.c)
                case "Java":
                    self.progressBarValue=Double(userScores.java)
                default:
                    print()
                }
                print(filteredList)
                
            }
            
        )
        .padding()
        
    }
}


