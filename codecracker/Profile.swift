//
//  Profile.swift
//  codecracker
//
//  Created by Gabriel Scholze on 10/12/24.
//

import SwiftUI

struct Profile: View {
    @FetchRequest(entity: UserScores.entity(), sortDescriptors: []) var scores: FetchedResults<UserScores>
    var body: some View {
        VStack {
                    Text("Your Scores")
                        .font(.title)
                        .padding(.bottom, 10)
                                        
                    VStack(spacing: 15) {
                        ScoreRow(language: "C", score: "\(scores.first!.c)")
                        ScoreRow(language: "Java", score: "\(scores.first!.java)")
                        ScoreRow(language: "JavaScript", score: "\(scores.first!.javascript)")
                        ScoreRow(language: "Python", score: "\(scores.first!.python)")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            Spacer()
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
       
        
    }
}

