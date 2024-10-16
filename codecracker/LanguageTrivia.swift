import MapKit
import SwiftUI

struct LanguageTrivia: View {
    var language: Language
    var userScores: UserScores
    @State private var showInfoPopover: Bool = false
    @Environment(\.managedObjectContext) var moc
    @State var currentQuestionIndex: Int = 1
    @State var position: MapCameraPosition
    @State private var selectedAnswer: Option? = nil
    @State private var isAnswerCorrect: Bool? = nil
    
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
                                .font(.caption)
                            Map(initialPosition: position.self)
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
                        handleAnswer(opt)
                    }) {
                        Text(opt.option!)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(buttonBackgroundColor(for: opt))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    .disabled(selectedAnswer != nil && selectedAnswer != opt && isAnswerCorrect == true)
                }
                
                Spacer()
            } else {
                Text("Congratulations! You've completed all questions for \(language.name!)")
                    .font(.headline)
            }
        }
        .padding()
        .onAppear{
            loadInitialScore()
        }
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
    
    func handleAnswer(_ selectedOption: Option) {
        selectedAnswer = selectedOption
        isAnswerCorrect = selectedOption.answer
        
        if selectedOption.answer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                currentQuestionIndex += 1
                selectedAnswer = nil
                isAnswerCorrect = nil
                updateUserScores()
                try? moc.save()
            }
        }
    }
    
    func buttonBackgroundColor(for option: Option) -> Color {
        if let selectedAnswer = selectedAnswer {
            if selectedAnswer == option {
                return isAnswerCorrect == true ? .green : .red
            } else if isAnswerCorrect == true {
                return .gray
            } else {
                return .indigo
            }
        } else {
            return .indigo
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
