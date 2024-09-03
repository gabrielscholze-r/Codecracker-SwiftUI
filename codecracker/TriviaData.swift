//
//  Question.swift
//  codecracker
//
//  Created by Gabriel Scholze on 8/31/24.
//
import SwiftUI

struct Language: Codable, Identifiable, Hashable,Equatable {
    var id: Int
    var name: String
    var questions: [Question]
    
}

struct Question: Codable, Identifiable,Hashable,Equatable  {
    var id: Int
    var question: String
    var options: [Option]

}

struct Option: Codable,Hashable,Equatable {
    var answer: Bool
    var option: String
}

struct UserScores: Codable{
    var java: Double
    var cpp: Double
}
