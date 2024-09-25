//
//  ContentView.swift
//  codecracker
//
//  Created by Gabriel Scholze on 8/31/24.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    //@StateObject var languageManager = LanguageManager()
    @FetchRequest(sortDescriptors: []) var language: FetchedResults<Language>
    @FetchRequest(sortDescriptors: []) var scores: FetchedResults<UserScores>
    init() {
        addLanguagesAndQuestions()
        try? moc.save()
    }
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(language) { l in
                        NavigationLink(value: l) {
                            Text(l.name!)
                        }
                    }
                }
                .navigationDestination(for:Language.self){item in
                    if let userScore = scores.first {
                            LanguageTrivia(language: item, userScores: userScore)
                        } else {
                            Text("No scores available")
                        }
                }
                .navigationTitle("CODECRACKER")
                .navigationBarTitleDisplayMode(.inline)
                
            }
            
        }
    }
    func addLanguagesAndQuestions() {
            // Create Languages C and Java
            let languageC = Language(context: moc)
            languageC.id = Int32(1)
            languageC.name = "C"

            let languageJava = Language(context: moc)
            languageJava.id = Int32(2)
            languageJava.name = "Java"
            
            // Questions for Language C
            let cQuestions = [
                ("What is the correct syntax for a main function in C?", [
                    ("int main() {}", true),
                    ("void main {}", false),
                    ("main() void", false),
                    ("def main():", false)
                ]),
                ("Which of the following is used to declare a pointer in C?", [
                    ("*", true),
                    ("&", false),
                    ("@", false),
                    ("#", false)
                ]),
                ("Which of these is not a loop structure in C?", [
                    ("for", false),
                    ("do-while", false),
                    ("repeat-until", true),
                    ("while", false)
                ])
            ]
            
            // Questions for Language Java
            let javaQuestions = [
                ("Which keyword is used to define a class in Java?", [
                    ("class", true),
                    ("struct", false),
                    ("define", false),
                    ("type", false)
                ]),
                ("What is the size of an int in Java?", [
                    ("4 bytes", true),
                    ("2 bytes", false),
                    ("8 bytes", false),
                    ("Depends on the system", false)
                ]),
                ("Which method is used to start a thread in Java?", [
                    ("start()", true),
                    ("run()", false),
                    ("init()", false),
                    ("execute()", false)
                ])
            ]
            
            // Adding questions to languages
            addQuestions(to: languageC, questionsData: cQuestions)
            addQuestions(to: languageJava, questionsData: javaQuestions)
        }

        func addQuestions(to language: Language, questionsData: [(String, [(String, Bool)])]) {
            for (questionText, optionsData) in questionsData {
                let question = Question(context: moc)
                question.id = Int32.random(in: 1...1000)
                question.question = questionText
                
                // Adding options to the question
                for (optionText, isCorrect) in optionsData {
                    let option = Option(context: moc)
                    option.answer = isCorrect
                    option.option = optionText
                    question.addToOptions(option)
                }
                
                // Adding question to the language
                language.addToQuestions(question)
            }
        }
}


#Preview {
    ContentView()
}
