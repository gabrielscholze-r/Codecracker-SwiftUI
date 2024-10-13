//
//  ScoreRow.swift
//  codecracker
//
//  Created by Gabriel Scholze on 10/12/24.
//

import SwiftUI

struct ScoreRow: View {
    var language: String
    var score: String
    var body: some View {
        HStack {
            Text(language)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
            
            Text(score)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)
                .padding()
                .background(Color.green.opacity(0.8))
                .cornerRadius(8)
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
}


