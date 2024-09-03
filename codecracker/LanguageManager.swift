//
//  LanguageManager.swift
//  codecracker
//
//  Created by Gabriel Scholze on 9/2/24.
//

import Foundation
class LanguageManager: ObservableObject {
  @Published var languages: [Language] = []
  @Published var userScores: UserScores = UserScores(java: 0, cpp: 0)

  init() {
      loadJsons()
  }

  func loadJsons() {
      if let path = Bundle.main.url(forResource: "data.json", withExtension: nil) {
          
          do{
              
              let data = try Data(contentsOf: path)
              
              let jsonLanguages = try JSONDecoder().decode([Language].self, from: data)
              self.languages = jsonLanguages
              
          }catch{
              
              print("Error!! Unable to parse data.json \(error.localizedDescription)")
          }
      };
      if let path = Bundle.main.url(forResource: "UserData.json", withExtension: nil) {
          
          do{
              
              let data = try Data(contentsOf: path)
              
              let jsonScores = try JSONDecoder().decode(UserScores.self, from: data)
              self.userScores = jsonScores
              
          }catch{
              
              print("Error!! Unable to parse UserData.json \(error.localizedDescription)")
          }
      }
  }
}
