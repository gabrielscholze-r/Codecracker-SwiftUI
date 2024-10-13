//
//  HomePage.swift
//  codecracker
//
//  Created by Gabriel Scholze on 10/12/24.
//
import CoreData
import SwiftUI

struct HomePage: View {
    @Environment(\.managedObjectContext) var moc
    var language: [Language]
    var scores: [UserScores]
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(language, id: \.self) { l in
                        NavigationLink(value: l) {
                            Text(l.name ?? "Unknown Language")
                        }
                    }
                }
                .navigationDestination(for: Language.self) { item in
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

    


    
}

