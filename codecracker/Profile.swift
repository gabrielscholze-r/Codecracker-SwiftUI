//
//  Profile.swift
//  codecracker
//
//  Created by Gabriel Scholze on 10/12/24.
//

import SwiftUI

struct Profile: View {
    @FetchRequest(entity: UserScores.entity(), sortDescriptors: []) var scores: FetchedResults<UserScores>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
            Text("Your Scores")
                .font(.title)
                .padding(.bottom, 10)
                
            VStack(spacing: 15) {
                ScoreRow(language: "C", score: "\(scores.first?.c ?? 0)")
                ScoreRow(language: "Java", score: "\(scores.first?.java ?? 0)")
                ScoreRow(language: "JavaScript", score: "\(scores.first?.javascript ?? 0)")
                ScoreRow(language: "Python", score: "\(scores.first?.python ?? 0)")
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
            .onAppear {
                if let firstScore = scores.first {
                    if firstScore.c == nil {
                        firstScore.c = 1
                    }
                    if firstScore.java == nil {
                        firstScore.java = 1
                    }
                    if firstScore.javascript == nil {
                        firstScore.javascript = 1
                    }
                    if firstScore.python == nil {
                        firstScore.python = 1
                    }
                    do {
                        try moc.save()
                    } catch {
                        print("Erro ao salvar: \(error.localizedDescription)")
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}
