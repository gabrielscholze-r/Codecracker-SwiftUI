//
//  ContentView.swift
//  codecracker
//
//  Created by user264588 on 8/31/24.
//
import SwiftUI

struct ContentView: View {
    @State var languages: [Language] = []
    
    
    
    var body: some View {
        VStack{
            
            NavigationStack {
                List {
                    ForEach(languages) { language in
                        NavigationLink(value: language) {
                            Text(language.name)
                            
                        }
                    }
                }.navigationDestination(for:Language.self){item in
                    LanguageTrivia(language: item)
                }.navigationTitle("CODECRACKER")
                .navigationBarTitleDisplayMode(.inline)
                
            }
            
        }.onAppear{
            loadJson()
        }
    }
    
    func loadJson(){
        if let path = Bundle.main.url(forResource: "data.json", withExtension: nil) {
            
            do{
                
                let data = try Data(contentsOf: path)
                
                let jsonLanguages = try JSONDecoder().decode([Language].self, from: data)
                self.languages = jsonLanguages
                
            }catch{
                
                print("Error!! Unable to parse data.json \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    ContentView()
}
