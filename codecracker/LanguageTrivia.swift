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
    @State private var showInfoPopover: Bool = false
    @Environment(\.managedObjectContext) var moc
    @State var currentQuestionIndex: Int = 1
    
    var filteredQuestions: [Question] {
        let questionsArray = language.questions?.allObjects as! [Question]
        return questionsArray.sorted { $0.id < $1.id }
    }
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < filteredQuestions.count else { return nil }
        return filteredQuestions[currentQuestionIndex]
    }
    
    var body: some View {
        VStack {
            if let question = currentQuestion {
                Text(language.name!)
                    .font(.title)
                    .fontWeight(.bold)
                
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(.indigo)
                    .onTapGesture {
                        showInfoPopover.toggle()
                    }
                    .popover(isPresented: $showInfoPopover) {
                        VStack {
                            Text(language.info ?? "No information available")
                                .padding()
                                .multilineTextAlignment(.leading)
                            
                            Button("Close") {
                                showInfoPopover = false
                            }
                            .padding()
                        }
                    }
                
                ProgressView("Score", value: Double(currentQuestionIndex), total: Double(filteredQuestions.count))
                    .padding(.horizontal, 64)
                
                Spacer()
                
                Text(question.question!)
                    .padding()
                
                ForEach(question.options?.allObjects as! [Option], id: \.self) { opt in
                    Button(action: {
                        handleAnswer(opt.answer) // Verifica se a resposta está correta
                    }) {
                        Text(opt.option!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            } else {
                Text("Congratulations! You've completed all questions for \(language.name!)")
                    .font(.headline)
            }
        }
        .padding()
        .onAppear(
            perform: loadInitialScore
        )
    }
    
    func loadInitialScore() {
        switch language.name {
        case "C":
            currentQuestionIndex = Int(userScores.c)
        case "Java":
            currentQuestionIndex = Int(userScores.java)
        case "Python":
            currentQuestionIndex = Int(userScores.python)
        case "JavaScript":
            currentQuestionIndex = Int(userScores.javascript)
        default:
            currentQuestionIndex = 1
            
            
        }
    }
    
    func handleAnswer(_ isCorrect: Bool) {
        if isCorrect {
            currentQuestionIndex += 1
            updateUserScores()
            try? moc.save()
        }
    }
    
    func updateUserScores() {
        switch language.name {
        case "C":
            userScores.c = Int32(currentQuestionIndex)
        case "Java":
            userScores.java = Int32(currentQuestionIndex)
        case "Python":
            userScores.python = Int32(currentQuestionIndex)
        case "JavaScript":
            userScores.javascript = Int32(currentQuestionIndex)
            
            
        default:
            break
        }
    }
}



