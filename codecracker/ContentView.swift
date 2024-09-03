//
//  ContentView.swift
//  codecracker
//
//  Created by Gabriel Scholze on 8/31/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var languageManager = LanguageManager()
    
    
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(languageManager.languages) { language in
                        NavigationLink(value: language) {
                            Text(language.name)
                            
                        }
                    }
                }.navigationDestination(for:Language.self){item in
                    LanguageTrivia(language: item, lm:languageManager)
                }.navigationTitle("CODECRACKER")
                .navigationBarTitleDisplayMode(.inline)
                
            }
            
        }
    }
}


#Preview {
    ContentView()
}
